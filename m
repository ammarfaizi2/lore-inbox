Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWAZIWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWAZIWB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 03:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWAZIWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 03:22:01 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:4957 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932126AbWAZIWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 03:22:00 -0500
Message-ID: <43D886A5.8010309@tls.msk.ru>
Date: Thu, 26 Jan 2006 11:21:57 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Akinobu Mita <mita@miraclelinux.com>
CC: Grant Grundler <iod00d@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH 3/12] generic ffz()
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com> <20060125200250.GA26443@flint.arm.linux.org.uk> <20060125205907.GF9995@esmail.cup.hp.com> <20060126032713.GA9984@miraclelinux.com> <20060126033156.GB11138@miraclelinux.com>
In-Reply-To: <20060126033156.GB11138@miraclelinux.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita wrote:
> This patch introduces the C-language equivalent of the function:
> unsigned long ffz(unsigned long word);
[]
> +#define ffz(x)	__ffs(~x)

please consider using
   #define ffz(x)	__ffs(~(x))

instead -- note the extra ()-pair

/mjt
