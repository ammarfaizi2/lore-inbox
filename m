Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318392AbSHPOj7>; Fri, 16 Aug 2002 10:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318407AbSHPOj7>; Fri, 16 Aug 2002 10:39:59 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:26632 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318392AbSHPOj6>;
	Fri, 16 Aug 2002 10:39:58 -0400
Date: Fri, 16 Aug 2002 07:39:25 -0700
From: Greg KH <greg@kroah.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [PATCH] add buddyinfo /proc entry
Message-ID: <20020816143925.GA3957@kroah.com>
References: <3D5C6410.1020706@us.ibm.com> <20020816043140.GA2478@kroah.com> <3D5CBCFC.2090006@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5CBCFC.2090006@us.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 19 Jul 2002 13:23:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 01:51:08AM -0700, Dave Hansen wrote:
> Greg KH wrote:
> > On Thu, Aug 15, 2002 at 07:31:44PM -0700, Dave Hansen wrote:
> >
> >> Not _another_ proc entry!
> >
> > Yes, not another one.  Why not move these to driverfs, where they
> > belong.
> 
> Could you show us how this particular situation might be laid out in a 
> driverfs/kfs/gregfs tree?

root/vm/buddyinfo   ?

Ah, a gregfs, making up the components that describe me...that's going
to be a pretty ugly looking fs...

> It's great that you keep suggesting this, but we have another 
> chicken-and-egg problem.
> 
> <SOAPBOX>
> The problem with driverfs today is that it isn't worth it for _me_ to
> use it to just get this one, single thing.  If I used driverfs right 
> now, the only thing that I would get out of it would be ... buddyinfo! 
> How is it worth my while to use it on a shared machine where most 
> people probably won't be mounting driverfs, or _want_ it mounted as 
> the default?
> </SOAPBOX>

All it takes is one line added to /etc/fstab mounting driverfs at /sys.
As the code is not a .config option, you are using it if you mount it or
not :)  The fact that no one else will look at that mount point,
shouldn't matter to you.

And yes, for just one thing (hey, why don't you move _all_ the vm stats
over to it), it is worth adding that one line.  And you'll eventually
have to do it anyway, as these things _will_ be moving there.

Hell, tell me which machine you are using, and I'll go add it.

> > (ignore the driverfs name, it should be called kfs, or some such
> > thing, as stuff more than driver info should go there, just like
> > these entries.)
> 
> If even its most ardent supporters don't like its name...

I don't have to like the name to like what it does, and is used for,
right?

thanks,

greg k-h

> 
> -- 
> Dave Hansen
> haveblue@us.ibm.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
