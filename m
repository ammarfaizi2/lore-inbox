Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLSBsr>; Mon, 18 Dec 2000 20:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129319AbQLSBsi>; Mon, 18 Dec 2000 20:48:38 -0500
Received: from mout0.freenet.de ([194.97.50.131]:63113 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S129228AbQLSBs1>;
	Mon, 18 Dec 2000 20:48:27 -0500
Date: Tue, 19 Dec 2000 03:25:31 +0000
From: Ingo Rohloff <lundril@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: A way to crash an 2.4-test11 kernel
Message-ID: <20001219032531.A1922@flashline.chipnet>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found a way to crash an SMP 2.4-test11 kernel:

1. Create a BIG file (lets say about 300-400 MByte)
2. use losetup and the loop device to create an
   ext2 filesystem within the file
3. mount the file
4. copy huge amounts of data into the file.
   (for example copy your /usr directory into it.)

-> Kernel deadlocks after some time.

Could someone try to reproduce this behaviour ?

so long
  Ingo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
