Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144516AbRA1XYt>; Sun, 28 Jan 2001 18:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144497AbRA1XYj>; Sun, 28 Jan 2001 18:24:39 -0500
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:18872 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S144498AbRA1XY3>; Sun, 28 Jan 2001 18:24:29 -0500
Message-ID: <3A74AA17.67EACE73@Home.net>
Date: Sun, 28 Jan 2001 18:24:07 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10a i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [IGNORE] Re: Kernel 2.4.1pre11 - Compile bug - Function prototype 
 change?
In-Reply-To: <3A74A981.51B1E382@Home.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nevermind, the low-latency patch changed this function.. ignore
Shawn Starr wrote:

> in include/linux/mm.h:
>
> -extern void zap_page_range(struct mm_struct *mm, unsigned long address,
> unsigned long size, int actions);
> +extern void zap_page_range(struct mm_struct *mm, unsigned long address,
> unsigned long size)
>
> The function has changed and breaks memory.c ?
>
> memory.c:352: conflicting types for `zap_page_range'
> /usr/src/linux/include/linux/mm.h:396: previous declaration of
> `zap_page_range'
> make[2]: *** [memory.o] Error 1
> make[2]: Leaving directory `/usr/src/linux/mm'
> make[1]: *** [first_rule] Error 2
> make[1]: Leaving directory `/usr/src/linux/mm'
> make: *** [_dir_mm] Error 2
>
> Shawn.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
