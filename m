Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUGIAa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUGIAa0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 20:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUGIAa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 20:30:26 -0400
Received: from neptune.fsa.ucl.ac.be ([130.104.233.21]:35032 "EHLO
	neptune.fsa.ucl.ac.be") by vger.kernel.org with ESMTP
	id S261711AbUGIAaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 20:30:25 -0400
Message-ID: <40EDE70C.40202@246tNt.com>
Date: Fri, 09 Jul 2004 02:30:04 +0200
From: Sylvain Munaut <tnt@246tnt.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] Freescale MPC52xx support for 2.6 - Base part
References: <40ED7C51.90103@246tNt.com> <17F799EA-D13C-11D8-A787-000393DBC2E8@freescale.com>
In-Reply-To: <17F799EA-D13C-11D8-A787-000393DBC2E8@freescale.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala wrote:

 > A few comments:
 >
 > cputable.c: * the 8280/52xx, maybe we should just have G2_LE, (same
 > core exists in 8272, 8249, etc.)

IMHO, yes it may be better.

 > mpc52xx_setup.c: * what is cpu_52xx[]?

A table with coefficients taken from datasheet. They're used to
compute the core frequency according to XLB bus frequency and external
jumper configurations.

 > ppcboot.h: * was bi_immr_base not sufficient?

I suppose your question is why create bi_mbar_base instead of using immr.
Well, I guess that would work just fine. The structure is just taken 
straight from U-Boot sources.

If the question was if I really need to add fields for the frequency, 
then the answer is yes. (Else, I must measure them which takes times and 
is inherently less precise).


Sylvain Munaut

