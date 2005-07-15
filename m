Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVGOWDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVGOWDw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 18:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVGOWDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 18:03:51 -0400
Received: from taxbrain.com ([64.162.14.3]:44379 "EHLO petzent.com")
	by vger.kernel.org with ESMTP id S261751AbVGOWC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 18:02:27 -0400
From: "karl malbrain" <karl@petzent.com>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.9 chrdev_open: serial_core: uart_open
Date: Fri, 15 Jul 2005 15:02:19 -0700
Message-ID: <NDBBKFNEMLJBNHKPPFILMEAMCEAA.karl@petzent.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <20050715225417.E23709@flint.arm.linux.org.uk>
X-Spam-Processed: petzent.com, Fri, 15 Jul 2005 14:58:33 -0700
	(not processed: message from valid local sender)
X-Return-Path: karl@petzent.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: petzent.com, Fri, 15 Jul 2005 14:58:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Russell King
> Sent: Friday, July 15, 2005 2:54 PM
> To: karl malbrain
> Cc: Linux-Kernel@Vger. Kernel. Org
> Subject: Re: 2.6.9 chrdev_open: serial_core: uart_open
>
>
> On Fri, Jul 15, 2005 at 02:17:01PM -0700, karl malbrain wrote:
> > > -----Original Message-----
> > > From: Russell King
> > > Sent: Friday, July 15, 2005 1:59 PM
> > > To: karl malbrain
> > > Cc: Linux-Kernel@Vger. Kernel. Org
> > > Subject: Re: 2.6.9 chrdev_open: serial_core: uart_open
> > >
> > >
> > > On Fri, Jul 15, 2005 at 01:52:15PM -0700, karl malbrain wrote:
> > > > On my 2.6.9-11EL source it clearly shows the up(&tty_sem) after
> > > the call to
> > > > uart_open. Init_dev never touches tty_sem.
> > >
> > > In which case, I have to say...
> > >
> > > Congratulations!  You've found a bug with Red Hat's Enterprise Linux
> > > kernel!  Go straight to Red Hat's bugzilla!  Do not collect 200$.  Do
> > > not pass go.
> > >
> > > Seriously though, this bug is not present in mainline kernels, so I
> > > can't resolve this issue for you.  Mainline kernels appear to work
> > > properly.
> >
> > Could tty_io.c be all that changed by a small set of red-hat patches to
> > 2.6.9?  Why would they need to go in there to make so many
> changes in the
> > first place?  Which 2.6 release changed tty_io.c's use of tty_sem so
> > heavily?
>
> These are questions to ask of Red Hat, and can only be answered by
> their representatives.

I've since answered part of my question.  Red Hat pulled some code-changes
from 2.6.10 tty_io.c with the somewhat cryptic comment "fix the trivial
exploits caused by Rolands controlling tty changes (part 1)" and moved the
tty_sem ops.

Do you know if this would be Roland at Red Hat, or a Roland at lkml?

Thanks, karl m



