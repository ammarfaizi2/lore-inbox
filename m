Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131913AbRCVIHo>; Thu, 22 Mar 2001 03:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131936AbRCVIHd>; Thu, 22 Mar 2001 03:07:33 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:1203 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131913AbRCVIHZ>; Thu, 22 Mar 2001 03:07:25 -0500
Message-ID: <3AB9B2F3.E8A012FE@uow.edu.au>
Date: Thu, 22 Mar 2001 19:08:19 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Greg Billock <greg@thebilberry.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] kernel BUG at slab.c:1402! -- 2.4.2-0.1.28
In-Reply-To: Your message of "Wed, 21 Mar 2001 23:15:14 -0800."
	             <3AB9A682.43D20AD7@thebilberry.com> <32245.985246611@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Wed, 21 Mar 2001 23:15:14 -0800,
> Greg Billock <greg@thebilberry.com> wrote:
> >Summary: Hotplugging a USB device causes an unrecoverable kernel Aiee!
> >
> >Copied from screen after interrupt handler killed, so sorry for
> >incompleteness. This
> >bug is reproducable so if necessary, I can try it again....
> 
> The complete oops report is required, and it needs to be run through
> ksymoops.  See Documentation/oops-tracing.txt.

It's a known problem, I think.  USB is incompatible
with slab redzoning.  Turn off `Debug memory allocation'
in the kernel hacking menu.
