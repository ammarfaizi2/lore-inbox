Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280659AbRKNPtK>; Wed, 14 Nov 2001 10:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280670AbRKNPtA>; Wed, 14 Nov 2001 10:49:00 -0500
Received: from mail317.mail.bellsouth.net ([205.152.58.177]:52442 "EHLO
	imf17bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280659AbRKNPsw>; Wed, 14 Nov 2001 10:48:52 -0500
Message-ID: <3BF2924C.B2213C1B@mandrakesoft.com>
Date: Wed, 14 Nov 2001 10:48:28 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: Richard Henderson <rth@twiddle.net>, Donald Maner <donjr@maner.org>,
        "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Compile error 2.4.15-pre4 on alpha
In-Reply-To: <C033B4C3E96AF74A89582654DEC664DB5576@aruba.maner.org> <3BF09ED5.54176F4F@mandrakesoft.com> <20011113165911.A1007@jurassic.park.msu.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> +/*
> + * We show only CPU #0 info.
> + */
> +static void *
> +c_start(struct seq_file *f, loff_t *pos)
> +{
> +       return *pos ? NULL : (char *)hwrpb + hwrpb->processor_offset;
> +}

only cpu0?  on SMP, cpu1/2/3/4 are not shown?

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

