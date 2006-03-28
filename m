Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWC1Vwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWC1Vwd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 16:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWC1Vwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 16:52:33 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:17974 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932335AbWC1Vwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 16:52:32 -0500
In-Reply-To: <20060328003508.2b79c050.akpm@osdl.org>
References: <20060328003508.2b79c050.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9F2A5122-5295-4B86-9AC5-3D002C5FD5D4@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 2.6.16-mm2
Date: Tue, 28 Mar 2006 15:52:33 -0600
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When building pmac32_defconfig for arch=powerpc:

drivers/built-in.o(.text+0x74cd4): In function `pciserial_init_ports':
: undefined reference to `serial8250_register_port'
drivers/built-in.o(.text+0x74d88): In function `pciserial_remove_ports':
: undefined reference to `serial8250_unregister_port'
drivers/built-in.o(.text+0x74e70): In function  
`pciserial_suspend_ports':
: undefined reference to `serial8250_suspend_port'
drivers/built-in.o(.text+0x74ee0): In function `pciserial_resume_ports':
: undefined reference to `serial8250_resume_port'

Need to hunt down why this is happening.

- kumar
