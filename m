Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264650AbSKDLjK>; Mon, 4 Nov 2002 06:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264651AbSKDLjK>; Mon, 4 Nov 2002 06:39:10 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:16390 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S264650AbSKDLjJ>; Mon, 4 Nov 2002 06:39:09 -0500
Message-Id: <200211041139.gA4Bdjp32237@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com
Subject: Re: [PATCH] Fix undeclared NULL in timer.h
Date: Mon, 4 Nov 2002 14:31:39 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
References: <20021104083918.126192C27F@lists.samba.org>
In-Reply-To: <20021104083918.126192C27F@lists.samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 November 2002 05:32, Rusty Russell wrote:
> Uncovered on a PPC compile: timer.h uses NULL, so needs stddef.h
>
> diff -urpN --exclude TAGS -X
> /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal
> .22822-2.5.45-bk-module-ppc.pre/include/linux/timer.h
> .22822-2.5.45-bk-module-ppc/include/linux/timer.h ---
> .22822-2.5.45-bk-module-ppc.pre/include/linux/timer.h	2002-10-31
> 12:37:02.000000000 +1100 +++
> .22822-2.5.45-bk-module-ppc/include/linux/timer.h	2002-11-04
> 18:28:53.000000000 +1100 @@ -3,6 +3,7 @@
>
>  #include <linux/config.h>
>  #include <linux/list.h>
> +#include <linux/stddef.h>
>
>  struct tvec_t_base_s;

The whole problem of #include forest going out of control
needs some clever solution or we will eternally chase missing
.h files
--
vda
