Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132381AbRAaQ50>; Wed, 31 Jan 2001 11:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132356AbRAaQ5Q>; Wed, 31 Jan 2001 11:57:16 -0500
Received: from md.aacisd.com ([64.23.207.34]:1808 "HELO md.aacisd.com")
	by vger.kernel.org with SMTP id <S132289AbRAaQ4z>;
	Wed, 31 Jan 2001 11:56:55 -0500
Message-ID: <8FED3D71D1D2D411992A009027711D67187E@md>
From: Nathan Black <NBlack@md.aacisd.com>
To: linux-kernel@vger.kernel.org
Subject: drive/block device write scheduling, buffer flushing?
Date: Wed, 31 Jan 2001 11:52:25 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering if there is a way to make the kernel write to disk faster. 
I need to maintain a 10 MB /sec write rate to a 10K scsi disk in a computer,
but it caches and doesn't start writing to disk until I hit about 700 MB. At
that point, it pauses(presumably while the kernel is flushing some of the
buffers) and I will have missed data that I am trying to capture.

Any ideas?

Nathan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
