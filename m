Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129645AbQKGGkG>; Tue, 7 Nov 2000 01:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129685AbQKGGj4>; Tue, 7 Nov 2000 01:39:56 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:35214 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129645AbQKGGjn>; Tue, 7 Nov 2000 01:39:43 -0500
Date: Mon, 06 Nov 2000 22:45:54 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
Subject: Re: malloc(1/0) ??
To: atmproj@yahoo.com, linux-kernel@vger.kernel.org
Reply-to: dank@alumni.caltech.edu
Message-id: <3A07A522.3D1914D2@alumni.caltech.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

atmproj@yahoo.com asked:
> [Why does this program not crash?]
>
> main() 
> { 
>    char *s; 
>    s = (char*)malloc(0); 
>    strcpy(s,"fffff"); 
>    printf("%s\n",s); 
> } 

It doesn't crash because the standard malloc is
optimized for speed, not for finding bugs.

Try linking it with a debugging malloc, e.g.
  cc bug.c -lefence
and watch it dump core.

- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
