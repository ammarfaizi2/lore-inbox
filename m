Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267246AbTAKPza>; Sat, 11 Jan 2003 10:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267257AbTAKPz3>; Sat, 11 Jan 2003 10:55:29 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:10148 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S267246AbTAKPz3>;
	Sat, 11 Jan 2003 10:55:29 -0500
Date: Sat, 11 Jan 2003 17:03:51 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301111603.RAA06278@harpo.it.uu.se>
To: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: Killing off the boot sector (was: [STATUS 2.5]  January 8, 2002)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Jan 2003 12:03:27 -0800, H. Peter Anvin wrote:
>Can we *please* kill off the stupid in-kernel boot sector?  The
>probing method it uses to determine geometry is unreliable (doesn't
>work on anything but true legacy floppies, not IDE, not USB, not
>firewire); it generates these kinds of requests; doesn't handle
>large-size kernels; hard-codes the use of address 0x90000 which isn't
>available on all machines; and overall promotes what's fundamentally
>bad practice.
>
>People keep asking what's the harm in keeping it, and the answer is,
>quite simply: "because people continue to try to use it."

While I have no particular affection for the in-kernel boot loader,
I do care about being able to test new kernels with 'make bzdisk'
as a regular user, using raw (no file system) floppies.

Last time I checked, LILO required both a file system and root privs
(for FIBMAP). Would syslinux work better?

/Mikael
