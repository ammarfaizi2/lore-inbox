Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275947AbSIUWiB>; Sat, 21 Sep 2002 18:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275948AbSIUWiB>; Sat, 21 Sep 2002 18:38:01 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:21263 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S275947AbSIUWiA>;
	Sat, 21 Sep 2002 18:38:00 -0400
Date: Sat, 21 Sep 2002 15:42:35 -0700
From: Greg KH <greg@kroah.com>
To: Francois Romieu <romieu@cogenit.fr>
Cc: linux-kernel@vger.kernel.org,
       hardeneddrivers-discuss@lists.sourceforge.net
Subject: Re: my review of the Device Driver Hardening Design Spec
Message-ID: <20020921224235.GA28936@kroah.com>
References: <mailman.1032587460.6299.linux-kernel2news@redhat.com> <200209211251.g8LCpFt23725@devserv.devel.redhat.com> <20020921181611.GA28315@kroah.com> <20020921235219.D15732@fafner.intra.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020921235219.D15732@fafner.intra.cogenit.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2002 at 11:52:19PM +0200, Francois Romieu wrote:
> [Cc list trimmed]
> 
> Greg KH <greg@kroah.com> :
> [...]
> > Oh, there's lots of code:
> > 	A "hardened" binary kernel driver:
> > 		http://unc.dl.sourceforge.net/sourceforge/hardeneddrivers/sampledriver-0.1-1.i386.rpm
> > 	(um people, why a binary?  Where's the source for this?)
> 
> In the cvs. See:
> http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/hardeneddrivers/sample_driver/src/

Thanks for pointing this out, I missed it.

Hm, if this is the code that the CG group is proposing for reliable
drivers, we are all in trouble.  See:
	http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/*checkout*/hardeneddrivers/sample_driver/src/sampledriver.h?rev=1.1.1.1

as a very small example of what not to do :)

I'd be glad to provide concrete criticism of the other files in this
directory, if I thought people would actually change their programming
style to follow what their own spec says to do...

{sigh}

http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/*checkout*/hardeneddrivers/sample_driver/src/sampledriver_init.c?rev=1.1.1.1
contains so many examples of bad style, and real bugs...

greg k-h
