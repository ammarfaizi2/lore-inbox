Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130516AbQLWH65>; Sat, 23 Dec 2000 02:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130522AbQLWH6r>; Sat, 23 Dec 2000 02:58:47 -0500
Received: from c266492-a.lakwod1.co.home.com ([24.1.8.253]:32013 "EHLO
	benatar.snurgle.org") by vger.kernel.org with ESMTP
	id <S130516AbQLWH6g>; Sat, 23 Dec 2000 02:58:36 -0500
Date: Sat, 23 Dec 2000 02:27:15 -0500 (EST)
From: William T Wilson <fluffy@snurgle.org>
To: Chris Wedgwood <cw@f00f.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Arg.  File > 2GB removal
In-Reply-To: <20001223202003.A9216@metastasis.f00f.org>
Message-ID: <Pine.LNX.4.21.0012230224170.14237-100000@benatar.snurgle.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Dec 2000, Chris Wedgwood wrote:

> rm probably stat'd the file beforing removing it -- and failed,
> because it's either old or uses and old library (which isn't LFS
> aware)

If that's true, then the following C programlet should remove the file:

Replace "huge-file-name" with the full path of your file, it needs to stay
in quotes.

---

#include <stdio.h>
#include <stdlib.h>

int main()
{
  unlink("huge-file-name");
  return 0;
}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
