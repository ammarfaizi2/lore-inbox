Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278073AbRJKC7B>; Wed, 10 Oct 2001 22:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278076AbRJKC6w>; Wed, 10 Oct 2001 22:58:52 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:3346 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S278073AbRJKC6l>; Wed, 10 Oct 2001 22:58:41 -0400
Date: Thu, 11 Oct 2001 04:59:09 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <laughing@shared-source.org>
Subject: Linux 2.4.10-ac11: swapoff frees memory + swap?
Message-ID: <20011011045909.A13276@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Alan Cox <laughing@shared-source.org>
In-Reply-To: <20011011001617.A4636@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20011011001617.A4636@lightning.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just ran efence 2.2.0 on an application, which eventually failed
because it could not mmap more memory.

My machine has 320 MB RAM and >~ 600 MB swap.

It swaps blazingly fast, but one strange observation. After the efenced
application had died at approx 300 MB in RAM and 180 MB of swap, I had
somewhat around 130 MB in swap and like 250 MB "USED+SHAR" as per
xosview. That looked too high a number, so I did swapoff -av, and after
that, I had 90 MB used. The swapoff was rather fast, compared with older
2.4.x vanilla kernels.

It may well be a cosmetic issue, but it's irritating that switching the
swap off looks like freeing main memory as well, one might expect pages
are swapped back into RAM, so USED increases.

Note, the xosview figures are backed by those of the "free" utility.

Any insights?

Matthias
