Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTKDPzs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 10:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTKDPzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 10:55:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:28046 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262323AbTKDPzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 10:55:46 -0500
Date: Tue, 4 Nov 2003 07:52:11 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Shirley Shi <shirley@kasenna.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: All filesystems hang under long periods of heavy load (read and
 write) on a filesystem
Message-Id: <20031104075211.5adcb42a.rddunlap@osdl.org>
In-Reply-To: <3FA6E8CE.6040208@kasenna.com>
References: <3FA6E8CE.6040208@kasenna.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Nov 2003 15:46:22 -0800 Shirley Shi <shirley@kasenna.com> wrote:

| Can anyone know why all filesystems hang under periods of heavy load on 
| one of the filesystem? Once the filesystems hang, any command related to 
| the filesystem, like 'ls', 'cat',etc., will stick forever until re-power 
| cycling the machine.
| 
| I kept running the following script to read and write the data on a same 
| filesystem(ext2 or XFS) since we need do some tests for the storage. Is 
| half day, onn the beginning, the system was running well. But after 
| running the script for a long time, such a half day, one day or two 
| days,  all filesystems would get hung, including the root filesystem 
| although I didn't do any heavy load on it. The file(M.1) I used for 
| reading and writing is about 2.5GB.
| 
| 
| @ total = 115
| while (1)
|   @ cc = 2
|   while ($cc <= $total)
|      dd bs=512k if=/data/M.1 of=/data/M.$cc
|     echo "copying $cc  of   $total..."
|     @ cc = $cc + 1
|   end
|   rm -f  /data/M.*
| end
| 
| 
| I tried RH8.0 with kernel 2.4.18 and kernel 2.4.21 with XFS and patch 
| rmap15j. I have the same issue running with the two kernels. Basically I 
| have two filesytems configured. One for the root configured with ext3, 
| and another is for the data configured with ext2 or XFS. With either 
| ext2 or XFS, I have the same problem.

Can you try a recent kernel, like 2.4.23-pre8 or -pre9?

--
~Randy
