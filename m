Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280032AbRKFTA6>; Tue, 6 Nov 2001 14:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280031AbRKFTAi>; Tue, 6 Nov 2001 14:00:38 -0500
Received: from web12201.mail.yahoo.com ([216.136.173.85]:52563 "HELO
	web12201.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S280015AbRKFTA3>; Tue, 6 Nov 2001 14:00:29 -0500
Message-ID: <20011106190029.54722.qmail@web12201.mail.yahoo.com>
Date: Tue, 6 Nov 2001 11:00:29 -0800 (PST)
From: Amit Kulkarni <amitncsu@yahoo.com>
Subject: Re: Insmod gives unsresolved symbol
To: Tommy Reynolds <reynolds@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011106085935.1888af63.reynolds@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In system.map there are no other charachters except
ipv4_explicit_null the line is 
c03c4900 B ipv4_explicit_null
same is true for all other symbols I added.

I am not sure what B indicates




--- Tommy Reynolds <reynolds@redhat.com> wrote:
> It was a dark and stormy night.  Suddenly "Amit
> Kulkarni" <amitncsu@yahoo.com> wrote:
> 
> > Hi 
> > 
> > I am trying to write a device driver which calls
> > certain functions/variables from the kernel 
> > (e.g. ipv4_explicit_null from
> > /usr/src/linux/net/mpls/mpls_init.c )
> > 
> > But when I try to insert the module using insmod
> it
> > gives me an error saying unresolved symbol
> > ipv4_explicit_null
> > 
> > thinking the kernel did not export the said symbol
>  I
> > added EXPORT_SYMBOL(ipv4_explicit_null) in the
> file
> > mpls_init.c 
> > Now I can see the symbol in System.map
> > but my problem still persists. 
> > 
> > Am I exporting symbols properly or is there
> anything
> > else that needs to be done .
> 
> I assume that you're trying to build a module
> outside the regular kernel build
> system.  You can do this if you are carefull.
> 
> Look carefully at the symbol in the System.map file.
>  Is it EXACTLY the
> "ipv4_explicit_null" symbol? Are the extra
> characters after the "...null" part
> of the name?  Any extra characters mean that you've
> got module versioning turned
> on in your kernel, so exported symbols have their
> name mangled somewhat as C++
> would do (this is to implement some protection since
> modules from one kernel
> version probably won't work with another kernel
> version).  The easiest solution
> to this is to recompile your kernel with module
> versioning turned off.
> 
>
---------------------------------------------+-----------------------------
> Tommy Reynolds                               |
> mailto: <reynolds@redhat.com>
> Red Hat, Inc., Embedded Development Services |
> Phone:  +1.256.704.9286
> 307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX: 
>   +1.256.837.3839
> Senior Software Developer                    |
> Mobile: +1.919.641.2923
> 

> ATTACHMENT part 2 application/pgp-signature 



__________________________________________________
Do You Yahoo!?
Find a job, post your resume.
http://careers.yahoo.com
