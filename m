Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbTIRBLn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 21:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbTIRBLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 21:11:43 -0400
Received: from port-212-202-170-64.reverse.qdsl-home.de ([212.202.170.64]:26775
	"EHLO idefix.rocklinux-consulting.de") by vger.kernel.org with ESMTP
	id S262925AbTIRBLl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 21:11:41 -0400
Date: Thu, 18 Sep 2003 01:11:36 +0000 (UTC)
Message-Id: <20030918.011136.884012564.rene.rebe@gmx.net>
To: jmoser5@student.ccbc.cc.md.us
Cc: linux-kernel@vger.kernel.org
Subject: Re: Small security option
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <Pine.A32.3.91.1030917204729.33040A-200000@student.ccbc.cc.md.us>
References: <Pine.A32.3.91.1030917204729.33040A-200000@student.ccbc.cc.md.us>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "idefix.localnet", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On: Wed, 17 Sep 2003 20:55:44 -0400 (EDT), John R
	Moser <jmoser5@student.ccbc.cc.md.us> wrote: > Why wasn't this done in
	the first place anyway? > > Some sysadmins like to disable the other
	boot devices and password-protect > the bios. Good, but if the person
	can pass init=, you're screwed. > > Here's a small patch that does a
	very simple thing: Disables "init=" and > using /bin/sh for init.
	That'll stop people from rooting the box from grub. [...] 
	Content analysis details:   (0.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On: Wed, 17 Sep 2003 20:55:44 -0400 (EDT),
    John R Moser <jmoser5@student.ccbc.cc.md.us> wrote:
> Why wasn't this done in the first place anyway? 
> 
> Some sysadmins like to disable the other boot devices and password-protect
> the bios.  Good, but if the person can pass init=, you're screwed. 
> 
> Here's a small patch that does a very simple thing: Disables "init=" and
> using /bin/sh for init. That'll stop people from rooting the box from grub. 

+  will also never be used as init.  This prevents users with physical
+  access to the machine from gaining root access by passing
+  init=/bin/bash to the kernel.
+
+  It is common to pass init=/bin/bash to the kernel to fix really
+  messed up machines.  If you say 'Y' here, you should make sure you
+  have a boot floppy with a kernel compiled with normal init code, OR
+  a rescue system such as a boot/root floppy or a Knoppix CD.

Erhm this adds no security - you know most people always have a USB
stick or Credit Card CD with a tiny Linux in the pocket? Or just take
the HD out of your box?

Maybe you should configure GRUB to need a password to change the
config on-the-fly to gain the same amount of "security"?

> The file is attatched.

Sincerely yours,
  René Rebe

--  
René Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene@rocklinux-consulting.de
http://www.rocklinux.org http://www.rocklinux-consulting.de
http://gsmp.tfh-berlin.de/gsmp http://gsmp.tfh-berlin.de/rene

