Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKOBLO>; Tue, 14 Nov 2000 20:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbQKOBLD>; Tue, 14 Nov 2000 20:11:03 -0500
Received: from pizda.ninka.net ([216.101.162.242]:64640 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129045AbQKOBKw>;
	Tue, 14 Nov 2000 20:10:52 -0500
Date: Tue, 14 Nov 2000 16:25:46 -0800
Message-Id: <200011150025.QAA01893@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: karrde@callisto.yi.org
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011150216460.28006-100000@callisto.yi.org>
	(message from Dan Aloni on Wed, 15 Nov 2000 02:25:38 +0200 (IST))
Subject: Re: [PATCH] Re: test11-pre5
In-Reply-To: <Pine.LNX.4.21.0011150216460.28006-100000@callisto.yi.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Wed, 15 Nov 2000 02:25:38 +0200 (IST)
   From: Dan Aloni <karrde@callisto.yi.org>

   Agreed. BTW, after grepping for IFNAMSIZ references I've noticed
   some architectures (sparc64, mips64) define IFNAMSIZ for
   themsleves, for example, arch/sparc64/kernel/ioctl32.c, which
   defines it to 16, the same include/linux/if.h does. But if they are
   not the same?

Then the compiler will start warning us :-)

#define FOO 6
#define FOO 6
int main(void)
{
	return FOO;
}
? gcc -Wall -o test test.c
? 
#define FOO 6
#define FOO 7
int main(void)
{
	return FOO;
}
? gcc -Wall -o test test.c
test.c:2: warning: `FOO' redefined
test.c:1: warning: this is the location of the previous definition
?

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
