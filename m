Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289853AbSBEXPX>; Tue, 5 Feb 2002 18:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289854AbSBEXPN>; Tue, 5 Feb 2002 18:15:13 -0500
Received: from melancholia.rimspace.net ([210.23.138.19]:2829 "EHLO
	melancholia.danann.net") by vger.kernel.org with ESMTP
	id <S289853AbSBEXOz>; Tue, 5 Feb 2002 18:14:55 -0500
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Warning, 2.5.3 eats filesystems
In-Reply-To: <20020205192826.GA112@elf.ucw.cz>
In-Reply-To: <20020205192826.GA112@elf.ucw.cz> (Pavel Machek's message of
 "Tue, 5 Feb 2002 20:28:26 +0100")
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
Date: Wed, 06 Feb 2002 10:14:39 +1100
Message-ID: <878za7wmg0.fsf@inanna.rimspace.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.5 (bamboo,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2002, Pavel Machek wrote:
> Hi!
> 
> 2.5.3 managed to damage my ext2 filesystem (few lost directories);
> beware.

I can confirm that there are filesystem corruption issues with 2.5.3;
after this message I rebooted and did a forced fsck which turned up
around a half dozen inodes where the block count in the inode itself was
too high.

The box has been rock solid before this. Configuration:

00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)

ext3 filesystem, data=journal mode.  P-II 400, 288MB.

        Daniel

-- 
C makes it easy to shoot yourself in the foot.
C++ makes it harder, but when you do, it blows away your whole leg.
        -- Bjarne Stroustrup
