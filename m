Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269999AbUJSRm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269999AbUJSRm3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 13:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269945AbUJSRkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 13:40:52 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:42246 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S269970AbUJSRhU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 13:37:20 -0400
Date: Tue, 19 Oct 2004 18:37:12 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: Andrew Morton <akpm@osdl.org>, ralf@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: fixed MIPS Makefile
In-Reply-To: <20041020003351.4f9ee7c0.yuasa@hh.iij4u.or.jp>
Message-ID: <Pine.LNX.4.58L.0410191834230.28336@blysk.ds.pg.gda.pl>
References: <20041020003351.4f9ee7c0.yuasa@hh.iij4u.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004, Yoichi Yuasa wrote:

>  #
> +# If you need data offset, please set up as follows.
> +#
> +# dataoffset-$(CONFIG_FOO) := <data offset value>
> +# 
> +
> +DATAOFFSET	:= $(shell if [ -z $(dataoffset-y) ] ; then echo "0"; \
> +			   else echo $(dataoffset-y); fi ;)

 Ugh, please consider using $(if ...).

  Maciej
