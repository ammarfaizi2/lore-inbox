Return-Path: <linux-kernel-owner+w=401wt.eu-S1423115AbWLUV1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423115AbWLUV1w (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 16:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423037AbWLUV1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 16:27:52 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:56994 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1423033AbWLUV1v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 16:27:51 -0500
X-Greylist: delayed 1478 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 16:27:51 EST
From: Ismail Donmez <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
To: David Miller <davem@davemloft.net>
Subject: Re: [Bugme-new] [Bug 7724] New: asm/types.h should define __u64 if isoc99
Date: Thu, 21 Dec 2006 23:03:15 +0200
User-Agent: KMail/1.9.5
Cc: akpm@osdl.org, netdev@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       uberlord@gentoo.org, linux-kernel@vger.kernel.org
References: <200612211617.kBLGHAAg028181@fire-2.osdl.org> <20061221124954.6bb415e9.akpm@osdl.org> <20061221.125850.125884789.davem@davemloft.net>
In-Reply-To: <20061221.125850.125884789.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612212303.16136.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

21 Ara 2006 Per 22:58 tarihinde, David Miller şunları yazmıştı: 
> From: Andrew Morton <akpm@osdl.org>
> Date: Thu, 21 Dec 2006 12:49:54 -0800
>
> > >            Summary: asm/types.h should define __u64 if isoc99
>
> Platform specific bug, and has nothing to do with networking.
>
> This problem will occur with any user visible interface definition
> that uses __u64, and there are several both in and outside the
> networking.

This bug hit KDE modules (kdebase/kdemultimedia/kdetv/...) many times, I 
workarounded with #undef ing __STRICT_ANSI__ before including kernel headers 
which is well ugly but works.

> x86 and perhaps others protect the __u64 definition with:
>
> 	defined(__GNUC__) && !defined(__STRICT_ANSI__)
>
> for whatever reason, probably to avoid "long long" or something like
> that.  But even that theory makes no sense.

Indeed this restriction just breaks userspace apps.

Regards,
ismail

-- 
Bir gün yolda yürüyordum... Bir şarkı duydum... Kalbim acıdı... Bu kadar...
