Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263130AbTCLKLs>; Wed, 12 Mar 2003 05:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263136AbTCLKLs>; Wed, 12 Mar 2003 05:11:48 -0500
Received: from dp.samba.org ([66.70.73.150]:61676 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263130AbTCLKLr>;
	Wed, 12 Mar 2003 05:11:47 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15983.2417.629541.924034@nanango.paulus.ozlabs.org>
Date: Wed, 12 Mar 2003 21:18:25 +1100 (EST)
To: Andrey Panin <pazke@orbita1.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] consolidate crc16 calculations (ppp part)
In-Reply-To: <20030312090207.GB1393@pazke>
References: <20030312090207.GB1393@pazke>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Panin writes:

> attached patch (2.5.64) converts aysnc ppp driver to use common crc16 module.
> 
> Please consider applying.

The only hesitation I have is that the Makefile system for the crc
functions seems to be broken - if you request to have the crc
functions built-in, but nothing built-in uses them, then the linker
doesn't included them.

Other than that I would say go for it.

Paul.
