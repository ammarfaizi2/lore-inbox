Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131382AbQLQAvw>; Sat, 16 Dec 2000 19:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131350AbQLQAvm>; Sat, 16 Dec 2000 19:51:42 -0500
Received: from jalon.able.es ([212.97.163.2]:36809 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131091AbQLQAvf>;
	Sat, 16 Dec 2000 19:51:35 -0500
Date: Sun, 17 Dec 2000 01:21:02 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: Linus's include file strategy redux
Message-ID: <20001217012102.E689@werewolf.able.es>
In-Reply-To: <91fiht$7ve$1@enterprise.cistron.net> <Pine.LNX.3.96.1001216084813.22767C-100000@tarot.mentasm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.3.96.1001216084813.22767C-100000@tarot.mentasm.org>; from ferret@phonewave.net on Sat, Dec 16, 2000 at 18:20:46 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lets try another scenario (from user point of view)
Ship kernel sources split in kernel-headers-2.2.18(tar.bz2,rpm,deb) and
kernel-source-2.2.18, and a binary kernel-2.2.18

One user not doing kernel compiles, but with various installed
kernels to try has:
/usr/include/kernel-2.2.18
/usr/include/kernel-2.4.0
/usr/include/kernel -> kernel-2.2.18 (setup at boot-init scripts 
                                      with uname -r)
User can compile userspace apps and test kernel modules including
/usr/include/kernel. If glibc is kernel independent, glibc headers
just include 'kernel'. If it is kernel dependent, include 
'kernel-x.y.z'.

User rebuilding kernel: kernel-source-x.y.z always look at
/usr/include/kernel-x.y.z, not just kernel.
A developer building a patched kernel that does not change headers
can manually do 
/usr/include/kernel-2.2.18-my-pre -> /usr/include/kernel-2.2.18
If he need to change headers, dup include tree.

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux werewolf 2.2.19-pre1 #1 SMP Fri Dec 15 22:25:20 CET 2000 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
