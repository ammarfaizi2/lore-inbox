Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVDUPzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVDUPzz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 11:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVDUPzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 11:55:55 -0400
Received: from main.gmane.org ([80.91.229.2]:26308 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261473AbVDUPzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 11:55:41 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Wes Felter <wesley@felter.org>
Subject: Re: Need AES benchmark on Intel 64 bit
Date: Thu, 21 Apr 2005 10:53:37 -0500
Message-ID: <d48i1q$moe$1@sea.gmane.org>
References: <42679C86.5050604@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pixpat.austin.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
In-Reply-To: <42679C86.5050604@domdv.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz wrote:
> Hi,
> can anybody help out? I don't have access to Intel 64 bit CPUs and need
> some microbenchmark results on Intel 64 bit. Usage guide for the
> attached archive:
> 
> 'ref' contains the current generic AES implementation
> 'new' contains the 64 bit AES assembler implementation

This is on a 3.6GHz Nocona:

wmf:~/src/aes/ref> ./aes
schedule128 1213
schedule192 1443
schedule256 1736
enc asm 128 1020
dec asm 128 1049
enc asm 192 1352
dec asm 192 1387
enc asm 256 1541
dec asm 256 1578
wmf:~/src/aes/ref> ./aes
schedule128 1214
schedule192 1442
schedule256 1736
enc asm 128 1021
dec asm 128 1049
enc asm 192 1352
dec asm 192 1388
enc asm 256 1541
dec asm 256 1579

wmf:~/src/aes/new> ./aes
schedule128 1276
schedule192 1520
schedule256 1822
enc asm 128 790
dec asm 128 795
enc asm 192 936
dec asm 192 937
enc asm 256 1087
dec asm 256 1086
wmf:~/src/aes/new> ./aes
schedule128 1276
schedule192 1520
schedule256 1821
enc asm 128 791
dec asm 128 796
enc asm 192 936
dec asm 192 937
enc asm 256 1087
dec asm 256 1086

Wes Felter - wesley@felter.org

