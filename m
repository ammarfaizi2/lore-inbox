Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265507AbRGEXSv>; Thu, 5 Jul 2001 19:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265515AbRGEXSl>; Thu, 5 Jul 2001 19:18:41 -0400
Received: from sncgw.nai.com ([161.69.248.229]:12932 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S265507AbRGEXSg>;
	Thu, 5 Jul 2001 19:18:36 -0400
Message-ID: <XFMail.20010705162149.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <E15II3b-0003T8-00@the-village.bc.nu>
Date: Thu, 05 Jul 2001 16:21:49 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ...
Cc: linux-kernel@vger.kernel.org, <phillips@bonn-fries.net (Daniel Phillips)>,
        <dwmw2@infradead.org (David Woodhouse)>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05-Jul-2001 Alan Cox wrote:
>> Life's a bitch.
>> cf. get_user(__ret_gu, __val_gu); (on i386)
>> 
>> Time to invent a gcc extension which gives us unique names? :)
> 
>#define min(a,b) __magic_minfoo(a,b, __var##__LINE__, __var2##__LINE__)
> 
>#define __magic_minfoo(A,B,C,D) \
>       { typeof(A) C = (A)  .... }

Anyway I think that :

int _a = 5;

for (;;) {
        int _a = _a;
        ...
}

must :

1) assign the upper level value of _a

or :

2) generate an compiler error





- Davide

