Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265571AbRGEXKc>; Thu, 5 Jul 2001 19:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265503AbRGEXJM>; Thu, 5 Jul 2001 19:09:12 -0400
Received: from t2.redhat.com ([199.183.24.243]:7415 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265563AbRGEXJE>; Thu, 5 Jul 2001 19:09:04 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E15II3b-0003T8-00@the-village.bc.nu> 
In-Reply-To: <E15II3b-0003T8-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: phillips@bonn-fries.net (Daniel Phillips),
        davidel@xmailserver.org (Davide Libenzi), linux-kernel@vger.kernel.org
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ... 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Jul 2001 00:08:55 +0100
Message-ID: <9756.994374535@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


#define min(a,b) __magic_minfoo(a,b, __var##__LINE__, __var2##__LINE__)

#define __magic_minfoo(A,B,C,D) \
	({ typeof(A) C = (A); typeof(B) D = (B); C>D?D:C; })

void main(void)
{
	int __var11=5, __var211=7;

	printf("min(%d,%d) = %d (should be 11: %d)\n", __var11, __var211, min(__var11, __var211), __LINE__);
}


--
dwmw2


