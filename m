Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267826AbUJGTXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267826AbUJGTXA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267708AbUJGTLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:11:23 -0400
Received: from fmr03.intel.com ([143.183.121.5]:29406 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S267852AbUJGTB0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 15:01:26 -0400
Message-ID: <4165927F.5040606@intel.com>
Date: Thu, 07 Oct 2004 12:01:19 -0700
From: Arun Sharma <arun.sharma@intel.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kill a sparse warning in binfmt_elf.c
References: <4164756E.4010408@intel.com> <200410071811.i97IBQf0031262@turing-police.cc.vt.edu>            <41658FB4.5090402@intel.com> <200410071854.i97IsvU5031703@turing-police.cc.vt.edu>
In-Reply-To: <200410071854.i97IsvU5031703@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/2004 11:54 AM, Valdis.Kletnieks@vt.edu wrote:

> And then go find the callers and make sure what they're passing is a
> 'const char __user *' rather than a 'const void *'....

Many callers in binfmt_elf.c are passing pointers that are kernel addresses. But file_operations->write() is expecting a __user pointer. The intention of the cast is to explicitly say that's an okay thing to do.

	-Arun

