Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTJZL0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 06:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTJZL0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 06:26:25 -0500
Received: from smtp1.att.ne.jp ([165.76.15.137]:14529 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S263077AbTJZL0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 06:26:24 -0500
Message-ID: <355901c39bb3$e6ca3a50$24ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Hans Reiser '" <reiser@namesys.com>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>, <linux-kernel@vger.kernel.org>,
       <nikita@namesys.com>, "'Justin Cormack '" <justin@street-vision.com>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
References: <346101c39b9e$35932680$24ee4ca5@DIAMONDLX60> <20031026092256.GA293@elf.ucw.cz>
Subject: Re: Blockbusting news, results end
Date: Sun, 26 Oct 2003 20:25:26 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek replied to me:

> > The drive finally reallocated the block and there are no longer any
> > visible bad blocks.
>
> And what was the operation that made it realocate?

At first I wasn't sure.  I noticed that the drive was behaving differently
when I told dd to use bs=4096 instead of 512.  Until seeing Oleg Drokin's
message about ReiserFS, I thought that the drive itself was doing something
differently.  That didn't make much sense to me because the physical sectors
are much longer than 4096 and the pseudo-sectors are the conventional 512,
so why did 4096 cause different behaviour?  From Oleg Drokin's message, I
guess that the use of 4096 might make a difference in the sequence of
read-modify-write cycles involved in the logical write operation.

This doesn't seem like a complete answer, but I don't think I'll ever know a
complete answer.

