Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129969AbQKGXeM>; Tue, 7 Nov 2000 18:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129940AbQKGXeD>; Tue, 7 Nov 2000 18:34:03 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:55347 "EHLO
	amsmta03-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129496AbQKGXdy>; Tue, 7 Nov 2000 18:33:54 -0500
Date: Wed, 8 Nov 2000 01:41:40 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: RAJESH BALAN <atmproj@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: malloc(1/0) ??
In-Reply-To: <20001107035905.18154.qmail@web3707.mail.yahoo.com>
Message-ID: <Pine.LNX.4.21.0011080140300.32613-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, RAJESH BALAN wrote:

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

malloc(0) is bogus in this case. malloc(0) == free();

>    strcpy(s,"fffff");
>    printf("%s\n",s);
> }
> 
> NOTE:
>   i know its a 'C' problem. but i wanted to know how
> this works 

The most plausible reason is you're not crossing a page boundary, and you
don't get a access violation.



	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
