Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVGZUr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVGZUr5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 16:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVGZUry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 16:47:54 -0400
Received: from taxbrain.com ([64.162.14.3]:25108 "EHLO petzent.com")
	by vger.kernel.org with ESMTP id S261929AbVGZUpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 16:45:36 -0400
From: "karl malbrain" <karl@petzent.com>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.9 chrdev_open: serial_core: uart_open
Date: Tue, 26 Jul 2005 13:45:25 -0700
Message-ID: <NDBBKFNEMLJBNHKPPFILOEBCCEAA.karl@petzent.com>
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
X-Spam-Processed: petzent.com, Tue, 26 Jul 2005 13:41:42 -0700
	(not processed: message from valid local sender)
X-Return-Path: karl@petzent.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: petzent.com, Tue, 26 Jul 2005 13:41:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Successful resolution!! The red-hat engineers monitoring their bugzilla list
posted a fix for tty_io.c Friday that works.  Thanks again for your help.
karl m

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
>
> Thanks anyway, and I'm sorry that this hasn't been resolved given
> the amount of time put into it by both of us.
>
> --
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core




