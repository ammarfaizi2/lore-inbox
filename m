Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129337AbQKGHy3>; Tue, 7 Nov 2000 02:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129615AbQKGHyT>; Tue, 7 Nov 2000 02:54:19 -0500
Received: from shell.webmaster.com ([209.133.28.73]:15324 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S129337AbQKGHyM>; Tue, 7 Nov 2000 02:54:12 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "RAJESH BALAN" <atmproj@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: RE: malloc(1/0) ??
Date: Mon, 6 Nov 2000 23:54:11 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKEEAJLMAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20001107035905.18154.qmail@web3707.mail.yahoo.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hi,
> why does this program works. when executed, it doesnt
> give a segmentation fault. when the program requests
> memory, is a standard chunk is allocated irrespective
> of the what the user specifies. please explain.
>
> main()
> {
>    char *s;
>    s = (char*)malloc(0);
>    strcpy(s,"fffff");
>    printf("%s\n",s);
> }
>
> NOTE:
>   i know its a 'C' problem. but i wanted to know how
> this works

	The program does not work. A program works if it does what it's supposed to
do. If you want to argue that this program is supposed to print "ffffff"
then explain to me why the 'malloc' contains a zero in parenthesis.

	The program can't possibly work because it invokes undefined behavior. It
is impossible to determine what a program that invokes undefined behavior is
'supposed to do'.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
