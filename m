Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265098AbSJWRFQ>; Wed, 23 Oct 2002 13:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265099AbSJWRFP>; Wed, 23 Oct 2002 13:05:15 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:5646 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265098AbSJWRFL>;
	Wed, 23 Oct 2002 13:05:11 -0400
Date: Wed, 23 Oct 2002 10:09:53 -0700
From: Greg KH <greg@kroah.com>
To: Richard J Moore <richardj_moore@uk.ibm.com>
Cc: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: 2.4 Ready list - Kernel Hooks
Message-ID: <20021023170952.GF13539@kroah.com>
References: <OF8955D2C4.965253CB-ON80256C5B.002C9AA3@portsmouth.uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF8955D2C4.965253CB-ON80256C5B.002C9AA3@portsmouth.uk.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 09:10:13AM +0100, Richard J Moore wrote:
> 
> >On Wed, Oct 23, 2002 at 12:09:38AM +0100, Richard J Moore wrote:
> >> We created
> >> kernel hooks for exactly the same reasons that LSM needs hooks - to allow
> >> ancillary function to exist outside the kernel, to avoid kernel bloat, to
> >> allow more than one function to be called from a given call-back (think of
> >> kdb and kprobes - both need to be called from do_debug).
> >
> >No, that is NOT the same reason LSM needs hooks!  LSM hooks are there to
> >mediate access to various kernel objects, from within the kernel itself.
> >Please do not confuse LSM with any of the above projects.
> 
> I would have to understand what you meant by "mediate between various
> kernel objects" to know whether LSM's need for hooks is radically different
> to RAS needs. Can you explain further?

Please read the LSM documentation for more information about this.  It
can be found in the kernel at:
	Documentation/DocBook/lsm.*
and there are a number of USENIX and OLS papers about different aspects
of the project at:
	lsm.immunix.org

In the beginning of the LSM project, both the DProbes and LTT groups
came asking that we use their patches to implement LSM.  It was
quickly determined that the types of "hooks" these projects offered was
not what the LSM group needed (or wanted).  So the current
implementation was developed.

Hope this helps.  If you have any further questions, please feel free to
ask (after reading that documentation :)

thanks,

greg k-h
