Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVBNQSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVBNQSo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 11:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVBNQSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 11:18:44 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:20935 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261461AbVBNQSm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 11:18:42 -0500
Date: Mon, 14 Feb 2005 17:19:50 +0100
From: DervishD <lkml@dervishd.net>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
Cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: How to get the maximum output from dmesg command
Message-ID: <20050214161950.GA10253@DervishD>
Mail-Followup-To: "Srinivas G." <srinivasg@esntechnologies.co.in>,
	linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
References: <4EE0CBA31942E547B99B3D4BFAB3481134E2AE@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB3481134E2AE@mail.esn.co.in>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Srinivas :)

 * Srinivas G. <srinivasg@esntechnologies.co.in> dixit:
> How to get maximum output from dmesg command? 
> I am unable to see all my debug messages after loading my driver. 
> I think there is a restriction in displaying the dmesg output. 
> I saw in printk.c file under source directory. There I found LOG_BUF_LEN
> is 16384.

    You can change this value using the configuration, namely
CONFIG_LOG_BUF_SHIFT. The value you store here is used to determine
LOG_BUF_LEN=2^CONFIG_LOG_BUF_SHIFT. You seem to have '14' as the
value of CONFIG_LOG_BUF_SHIFT. Increase it to 16 and you will have 4
times the current length for the dmesg buffer.

    I'm assuming you're using a more or less recent 2.4.x kernel. I
suppose that the same is applicable to 2.6.x kernels.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
