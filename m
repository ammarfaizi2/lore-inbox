Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbSJKIxN>; Fri, 11 Oct 2002 04:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262365AbSJKIxM>; Fri, 11 Oct 2002 04:53:12 -0400
Received: from syr-24-92-226-122.nyroc.rr.com ([24.92.226.122]:20792 "EHLO
	mailout5-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S262360AbSJKIxM>; Fri, 11 Oct 2002 04:53:12 -0400
Message-ID: <009101c27104$6b265f80$7b00a8c0@enigma>
From: "Nicholas Hockey" <tilt@bitchx.org>
To: "Pavel Machek" <pavel@ucw.cz>, "Dow, Benjamin" <bdow@itouchcom.com>
Cc: <linux-kernel@vger.kernel.org>, "'Rik van Riel'" <riel@conectiva.com.br>
References: <19EE6EC66973A5408FBE4CB7772F6F0A046A39@ltnmail.xyplex.com> <20021008225400.GA889@elf.ucw.cz>
Subject: Re: kernel memory leak?
Date: Fri, 11 Oct 2002 04:58:50 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i am having a similar problem, i'm thinking somthing in the XFS software is
malloc()ing ram and not letting it go, by any chance are you using XFS ?
what i did was write this lil things to recover my ram,it eats ram till it's
killed effectivly recovering lost ram (i just had to include this)
---ayrabtu.c---
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
        char *allyourram;
        char arebelongtous[] = "all your ram are belong to us";

        while (1) {
                allyourram = malloc(30);
                sprintf(allyourram, "%s", arebelongtous);
        }

        return(0);
}
---EOF---
(sorry if this posts twice)


