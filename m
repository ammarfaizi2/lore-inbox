Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbUCATFk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 14:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbUCATFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 14:05:40 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:11467 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261400AbUCATFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 14:05:39 -0500
Subject: Re: [CFT][PATCH] 2.6.4-rc1 remove x86 boot page tables
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m1vflp81kq.fsf@ebiederm.dsl.xmission.com>
References: <m1vflp81kq.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Message-Id: <1078167938.27444.43.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 01 Mar 2004 11:05:38 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-29 at 23:32, Eric W. Biederman wrote:
> I have rewritten and compiled tested the boot_ioremap code but I don't
> have a configuration to test it. This effects the EFI code and the
> numa srat code.   It might be worth replacing boot_ioremap with __va()
> to reduce the amount of error checking necessary.

I can probably have someone test it, but you're right, we don't really
need boot_ioremap() if we're going to map in all 4G at boot time.  I'd
just prefer that you remove it completely in your patch.  

I can test it on some SRAT hardware if you'd like.  

-- dave

