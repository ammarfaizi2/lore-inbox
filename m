Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269764AbUINUlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269764AbUINUlv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269656AbUINUkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:40:19 -0400
Received: from mail2.iserv.net ([204.177.184.152]:31969 "EHLO mail2.iserv.net")
	by vger.kernel.org with ESMTP id S269668AbUINUkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 16:40:01 -0400
Message-ID: <41475716.2020102@didntduck.org>
Date: Tue, 14 Sep 2004 16:39:50 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Zaitsev <zzz@anda.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.8.1/x86] The kernel is _always_ compiled with -msoft-float
References: <20040915021418.A1621@natasha.ward.six>
In-Reply-To: <20040915021418.A1621@natasha.ward.six>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Zaitsev wrote:
> Why this kernel is always compiled with the FP emulation for x86?
> This is the line from the beginning of arch/i386/Makefile:
> 
> CFLAGS += -pipe -msoft-float
> 
> And it's hardcoded, it does not depend on CONFIG_MATH_EMULATION.  So,
> is this just a typo or not?

To trap use of floating point in the kernel (not allowed).  FPU 
emulation is only for userspace.

--
				Brian Gerst
