Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264845AbSJaKxS>; Thu, 31 Oct 2002 05:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264849AbSJaKxS>; Thu, 31 Oct 2002 05:53:18 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:58244 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264845AbSJaKxQ>; Thu, 31 Oct 2002 05:53:16 -0500
Subject: Re: [PATCH] fixes for building kernel 2.5.45 using Intel compiler
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000EFF4249@fmsmsx103.fm.intel.com>
References: <F2DBA543B89AD51184B600508B68D4000EFF4249@fmsmsx103.fm.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 31 Oct 2002 11:19:34 +0000
Message-Id: <1036063174.8575.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 03:17, Nakajima, Jun wrote:
>  asmlinkage int sys_iopl(unsigned long unused)
>  {
> -	struct pt_regs * regs = (struct pt_regs *) &unused;
> +	volatile struct pt_regs * regs = (struct pt_regs *) &unused;

Why is this needed ?


> -	IGNLABEL "HmacRxUc",
> -	IGNLABEL "HmacRxDiscard",
> -	IGNLABEL "HmacRxAccepted",
> +	IGNLABEL /* "HmacTxMc", */
> +	IGNLABEL /* "HmacTxBc", */

You seem to be removing fields from the struct - have you tested this ?


