Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129823AbQKEScX>; Sun, 5 Nov 2000 13:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129822AbQKEScO>; Sun, 5 Nov 2000 13:32:14 -0500
Received: from demai05.mw.mediaone.net ([24.131.1.56]:31934 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S129779AbQKEScD>; Sun, 5 Nov 2000 13:32:03 -0500
Message-ID: <3A05A724.216E04F3@iname.com>
Date: Sun, 05 Nov 2000 13:29:56 -0500
From: Sean Middleditch <sean.middleditch@iname.com>
Organization: AwesomePlay Productions
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-9mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic - weird error
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, if this is the wrong list for help questions, please let me know
- I've been searching for answers to this since 10 am (it's 1:20 pm
now), and this is the last resource I can find that might offer some
help.  ~,^

I've installed the Linux-Mandrake 7.2 distro (which uses kernel version
2.2.17) on a PIII system (Asus motherboard, Award Medallion v6.0 BIOS).
For some reason, neither LILO nor Grub were able to boot off of the
second hard-drive (where Linux is).  I've copied over the kernel, and a
few other LILO files to a Windows partition on the primary drive.  Now,
LILO can load the kernel, and the kernel begins to boot.

First, I noticed this during the IDE detection:
  hdd [PTBL] [784/255/53] hdd1 < hdd5 hdd6 >
I've never seen the "[PTBL] [784/255/53]" part before on any Linux
system, so I was unsure if this was important.

Then, after the raid detection (no, I don't have one, this is a default
Mandrake kernel), I get this error:
    "Invalid session number or type of track"
which, after searching through the kernel sources, I found was an isofs
error.
Right after this error, I get a kernel panic, unable to mount root fs...

The drives are configued like this -

  Maxtor 27GB on primary IDE (UDMA/66), master
  Creative DVD 5x on secondary IDE (UDMA/33), master
  Quantum 6GB on secondary IDE (UDMA/33), slave

Linux is on the Quantum 6GB hard-drive.  Windows is installed on the
Maxter 27GB.  Windows boots fine with or without LILO.

I've had older versions of Linux running before on this system.  I'm
confused as to why this is happening, although I suspect a faulty BIOS.
I've also suspected that there may be a problem with the hard-drive on
the secondary IDE bus being slave with the DVD drive as master, as I'm
told this is usually a Bad Idea; although I'm not allowed to move it
(it's not my machine), and the owner (my father) doesn't want to move
anything unless he absolutely has to, which I've yet to convince him of
(after all, Windows works, and that's all he uses - for now).

If there's any other info I should give, please let me know.

Thank you,
Sean Etc.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
