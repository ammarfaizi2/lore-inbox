Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262496AbREUVe3>; Mon, 21 May 2001 17:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262494AbREUVeU>; Mon, 21 May 2001 17:34:20 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51464 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262496AbREUVeH>; Mon, 21 May 2001 17:34:07 -0400
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
To: viro@math.psu.edu (Alexander Viro)
Date: Mon, 21 May 2001 22:29:50 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), pavel@suse.cz (Pavel Machek),
        rgooch@ras.ucalgary.ca (Richard Gooch),
        matthew@wil.cx (Matthew Wilcox), clausen@gnu.org (Andrew Clausen),
        bcrl@redhat.com (Ben LaHaise), torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0105211639250.12245-100000@weyl.math.psu.edu> from "Alexander Viro" at May 21, 2001 04:41:48 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E151xFO-0000ue-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which, BTW, is a wonderful reason for having multiple channels. Instead
> of write(fd, "critical_command", 8); read(fd,....); you read from the right fd.
> Opened before you enter the hotspot. Less overhead than ioctl() would
> have...

The ioctl is one syscall, the read/write pair are two. Im not sure that ioctl
is going to be more overhead there. In the video4linux case the high overhead
is acking frames received by mmap so might conceivably be considered one way

