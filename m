Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbTLALxJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 06:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbTLALxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 06:53:08 -0500
Received: from pop.gmx.de ([213.165.64.20]:8390 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262747AbTLALxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 06:53:06 -0500
X-Authenticated: #2203603
Message-ID: <013301c3b801$6c595de0$7727048b@de.uu.net>
From: "Daniel Flinkmann" <dflinkmann@gmx.de>
To: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Corrupt files with kernel 2.6.0_test11 and smb mounts
Date: Mon, 1 Dec 2003 12:51:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [1.] One line summary of the problem:
>
> 2.6.0test11 overwriting file on mounted smb volume causes corrupted files!
>
> [2.] Full description of the problem/report:
>
> When I log into a smb mounted directory and I overwrite a file with
> a file which has smaller amount of bytes its corrupting the data.
>
> Easy way to show this is following:
>
> cd onto a smbfs mounted dir.
>
> ># echo test1234567890 >test.txt
> ># cat test.txt
> test1234567890
> ># echo hi! >test.txt
> ># cat test.txt
> hi!
> 1234567890
> >#
>
> As you can see the file is not overwritten as it should be.
>

Ookhoi reported the same Problem with 2.6.0_test9 in the Samba Group:
http://lists.samba.org/archive/samba-technical/2003-November/032847.html

This could also be a Memorymanagement problem because the filesystem is
always breaking the last block, which is handled different to the other
blocks.

Daniel


