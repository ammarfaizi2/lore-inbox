Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbUCPWgc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 17:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbUCPWgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 17:36:32 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:56497 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261780AbUCPWfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 17:35:36 -0500
Message-ID: <4057805A.6060209@acm.org>
Date: Tue, 16 Mar 2004 16:31:54 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm1: IPMI_SMB still doesn't compile
References: <20040316015338.39e2c48e.akpm@osdl.org> <20040316124035.GN27056@fs.tum.de>
In-Reply-To: <20040316124035.GN27056@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, let's pull the SMBus driver for now, until we can get the I2C 
changes in.

Andrew, do you want a patch?

-Corey

Adrian Bunk wrote:

>On Tue, Mar 16, 2004 at 01:53:38AM -0800, Andrew Morton wrote:
>  
>
>>...
>>All 253 patches:
>>...
>>ipmi-updates-3.patch
>>  IPMI driver updates
>>...
>>    
>>
>
>IPMI_SMB still causes the following compile error:
>
><--  snip  -->
>
>...
>  LD      .tmp_vmlinux1
>drivers/built-in.o(.text+0x135a0b): In function `smbus_client_read_block_data':
>: undefined reference to `i2c_set_spin_delay'
>drivers/built-in.o(.text+0x135bad): In function `smbus_client_write_block_data':
>: undefined reference to `i2c_set_spin_delay'
>drivers/built-in.o(.text+0x13629f): In function `set_run_to_completion':
>: undefined reference to `i2c_set_spin_delay'
>make: *** [.tmp_vmlinux1] Error 1
>
><--  snip  -->
>
>
>Until this issue is sorted out, please either drop ipmi-updates-3.patch
>or remove the SMBus IPMI driver from this patch.
>
>cu
>Adrian
>
>  
>


