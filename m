Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280027AbRKXVTg>; Sat, 24 Nov 2001 16:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280110AbRKXVTY>; Sat, 24 Nov 2001 16:19:24 -0500
Received: from marine.sonic.net ([208.201.224.37]:23088 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S280027AbRKXVTF>;
	Sat, 24 Nov 2001 16:19:05 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Sat, 24 Nov 2001 13:19:02 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Moving ext3 journal file
Message-ID: <20011124131902.A537@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E167Fuw-00001K-00@DervishD> <Pine.LNX.4.33.0111231944430.2891-100000@fargo> <20011123155901.C1308@lynx.no> <9tmocg$jfn$1@cesium.transmeta.com> <20011124115411.C25094@joshua.mesa.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011124115411.C25094@joshua.mesa.nl>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 11:54:11AM +0100, Marcel J.E. Mol wrote:
> On Fri, Nov 23, 2001 at 04:07:44PM -0800, H. Peter Anvin wrote:
> > This is all fine and good except for the root partition (I'm pleased
> > to hear that e2fsck 1.25 will move the journal to the hidden inode for
> > non-root partitions.)  It would be nice if this was done automagically
> > by the mounting code instead of by fsck; that way migration would
> > truly be painless.
> 
> Hm, the e2fsck check does not work for me...
> The .journal file still exists after
> 
>    # umount /dev/hda11
>    # e2fsck -f /dev/hda11
>    # mount /dev/hda11
>    # rpm -q e2fsprogs
>    e2fsprogs-1.25-1

I was just going to comment on this as well.  I cannot get this to work as
advertised on a homegrown system as well.

Even tune2fs -l | grep inode and ls -i .journal show it's still using the
same inode.

Actually, a quick look through the code, I can't see where e2fsck would
take measures to hide .journal.  At least not in 1.25.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
