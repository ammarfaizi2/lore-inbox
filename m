Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268963AbRIPI7M>; Sun, 16 Sep 2001 04:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268940AbRIPI7D>; Sun, 16 Sep 2001 04:59:03 -0400
Received: from [213.17.90.247] ([213.17.90.247]:39947 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S268837AbRIPI6w>; Sun, 16 Sep 2001 04:58:52 -0400
Message-Id: <200109160858.KAA28624@cave.bitwizard.nl>
Subject: Re: How errorproof is ext2 fs?
In-Reply-To: <E15hebh-0007QK-00@the-village.bc.nu> from Alan Cox at "Sep 13,
 2001 11:05:13 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sun, 16 Sep 2001 10:58:46 +0200 (MEST)
CC: otto.wyss@bluewin.ch, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > due to an not responding USB-keyboard/-mouse (what a nice coincident). Now while
> > the Mac restarted without any fuse I had to fix the ext2-fs manually for about
> > 15 min. Luckily it seems I haven't lost anything on both system. 
> > 
> > This leaves me a bad taste of Linux in my mouth. Does ext2 fs really behave so
> > worse in case of a crash? Okay Linux does not crash that often as MacOS does, so
 
> That sounds like it behaved well. fsck didnt have enough info to safely
> do all the fixup without asking you. Its not a reliability issue as such.

Well, fsck wants to ask 

	"Found an unattached inode, connect to lost+found?"

to the user and will interrupt an automatic reboot for that.

This is bad: The safe choice is safe: It won't cause data-loss. 

Maybe it should report it (say by Email), but interrupting a reboot
just for connecting a couple of files to lost+found, that's
rediculous.

If it would give me enough information when I do this manually, I'd
make an informed decision. However, what are the chances of me knowing
that inode 123456 is a staroffice bak-file? So the only way to safely
operate is to link them into lost+found, and then to look at the files
manually.

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
