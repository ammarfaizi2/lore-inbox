Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280075AbRKEAPo>; Sun, 4 Nov 2001 19:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280071AbRKEAPe>; Sun, 4 Nov 2001 19:15:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41994 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280064AbRKEAPV>; Sun, 4 Nov 2001 19:15:21 -0500
Subject: Re: Special Kernel Modification
To: lonnie@outstep.com (Lonnie Cumberland)
Date: Mon, 5 Nov 2001 00:22:27 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BE5D6EC.8040204@outstep.com> from "Lonnie Cumberland" at Nov 04, 2001 07:01:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E160XX1-0003ZC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have look into using things like "chroot" to restrict the users for 
> this very special server, but that solution is not what we need.

It sounds like it is to me

> My problem is that I need to find a way to prevent the user from 
> navigating out of their home directories.

Then you must put al the files in their home directories. Alternatively
with later 2.4 you can use bind mounts to remount the application file
systems below the user.

> Is there someone who might be able to give me some information on how I 
> could add a few lines to the VFS filesystem so that I might set some 
> type of extended attribute to prevent users from navigating out of the 
> locations.

It isnt down to attributes - how you can run a binary or load a shared
library you cant see.

You might also want to see http://www.nsa.gov/selinux, but that would
require a lot of careful policy setup
