Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262510AbREUWCE>; Mon, 21 May 2001 18:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262509AbREUWBz>; Mon, 21 May 2001 18:01:55 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19977 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262505AbREUWBn>; Mon, 21 May 2001 18:01:43 -0400
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
To: viro@math.psu.edu (Alexander Viro)
Date: Mon, 21 May 2001 22:56:35 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), pavel@suse.cz (Pavel Machek),
        rgooch@ras.ucalgary.ca (Richard Gooch),
        matthew@wil.cx (Matthew Wilcox), clausen@gnu.org (Andrew Clausen),
        bcrl@redhat.com (Ben LaHaise), torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0105211745490.12245-100000@weyl.math.psu.edu> from "Alexander Viro" at May 21, 2001 05:51:08 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E151xfH-0000xg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sure. But we have to do two syscalls only if ioctl has both in- and out-
> arguments that way. Moreover, we are talking about non-trivial in- arguments.
> How many of these are in hotspots?

There is also a second question. How do you ensure the read is for the right 
data when you are sharing a file handle with another thread..

ioctl() has the nice property that an in/out ioctl is implicitly synchronized

