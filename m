Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276766AbRJHCh1>; Sun, 7 Oct 2001 22:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276327AbRJHChQ>; Sun, 7 Oct 2001 22:37:16 -0400
Received: from nsd.mandrakesoft.com ([216.71.84.35]:12356 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S276766AbRJHChL>; Sun, 7 Oct 2001 22:37:11 -0400
Date: Sun, 7 Oct 2001 21:37:22 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: "Eric W. Biederman" <ebiederman@uswest.net>
cc: Pavel Machek <pavel@Elf.ucw.cz>, Jeremy Elson <jelson@circlemud.org>,
        linux-kernel@vger.kernel.org
Subject: linmodems (was Re: [ANNOUNCE] FUSD v1.00: Framework for User-Space Devices)
In-Reply-To: <m1n132x4qg.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.3.96.1011007213223.2882B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Oct 2001, Eric W. Biederman wrote:
> Pavel Machek <pavel@Elf.ucw.cz> writes:
> > Yep. And linmodem driver does signal processing, so it is big and
> > ugly. And up till now, it had to be in kernel. With your patches, such
> > drivers could be userspace (where they belong!). Of course, it would be 
> > very good if your interface did not change...

> I don't see how linmodem drivers apply.  At least not at the low-level
> because you actually have to driver the hardware, respond to interrupts
> etc.  On some of this I can see a driver split like there is for the video
> card drivers, so the long running portitions don't have to be in the kernel.

My best guess for a Linux winmodem solution for Linux is three pieces:
The existing Lucent (and other) hardware work (by Pavel/Richard/Jamie/others?)
Rogier Wolff's user space serial driver code, and
A work called "modem" by a now-deceased scientist at SGI(IIRC).  Alan
pointed me to the last piece.  'modem' handles up to 14.4k speed, and
supports some error correcting protocols we all remember from the BBS
days.

Just need someone to glue those pieces together... and you have a
winmodem driver with the proper portions in userspace, and the proper
portions in kernel space.

	Jeff




