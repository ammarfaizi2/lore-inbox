Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWA0FXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWA0FXt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 00:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWA0FXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 00:23:49 -0500
Received: from hierophant.serpentine.com ([66.92.13.71]:30149 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S1750718AbWA0FXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 00:23:48 -0500
Subject: Re: [PATCH 8/12] generic hweight{32,16,8}()
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: Grant Grundler <iod00d@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
In-Reply-To: <20060127044303.GA6594@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com>
	 <20060125113206.GD18584@miraclelinux.com>
	 <20060125200250.GA26443@flint.arm.linux.org.uk>
	 <20060125205907.GF9995@esmail.cup.hp.com>
	 <20060126032713.GA9984@miraclelinux.com>
	 <20060126033613.GG11138@miraclelinux.com>
	 <1138301867.12632.71.camel@serpentine.pathscale.com>
	 <20060127044303.GA6594@miraclelinux.com>
Content-Type: text/plain
Date: Thu, 26 Jan 2006 21:23:47 -0800
Message-Id: <1138339428.9435.7.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-27 at 13:43 +0900, Akinobu Mita wrote:

> I think it's better than adding many HAVE_ARCH_*_BITOPS.
> I will have 14 new headers. So I want to make new directory
> include/asm-generic/bitops/:

While you're thrashing all that stuff, have you thought about adding
generic support for the atomic_*_mask functions?  Only eight of almost
30 arches actually implement them, which makes them worthless for
portable drivers.  The same approach you're using now with other bitops
will work equally well, or be just as broken, depending on the arch in
question :-)

	<b

