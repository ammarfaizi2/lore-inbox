Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293014AbSB0Wdu>; Wed, 27 Feb 2002 17:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293011AbSB0WdD>; Wed, 27 Feb 2002 17:33:03 -0500
Received: from mout0.freenet.de ([194.97.50.131]:42906 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S293009AbSB0WbT>;
	Wed, 27 Feb 2002 17:31:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Franck <afranck@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, florin@iucha.net (Florin Iucha)
Subject: Re: Linux 2.4.19pre1-ac1
Date: Wed, 27 Feb 2002 23:31:24 +0100
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <02022723312400.01097@dg1kfa>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florin, hi Alan,

> With 19-pre1-ac1 on a reiserfs partition I cannot patch a kernel. Patch
> fails with "Invalid cross-device link" or "Out of disk space".

I can reproduce this too on ext2, so this does not seem to be FS related. 

However, I do not get this error messages, the patch runs just fine,
but corrupts all files it touches, leaving them to be all a bit less than 
1MiB of size, and all exactly the same size.

There is no filesystem corruption however, e2fsck runs just fine without any 
error. Just the files are all damaged. I looked inside them, and it seems 
huge parts of other files from the patch have been "attached" to them.

> 18-rc2-ac1 works fine on the same partition.

ACK, for me too; as well as 2.4.18-rc2-ac2 for me. The breakage starts with
2.4.18-ac1 here.  Plain 2.4.18 from Marcelo works fine as well.

Greetings,
Andreas
