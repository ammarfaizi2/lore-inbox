Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVC2FHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVC2FHa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 00:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVC2FHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 00:07:30 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:36519 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262191AbVC2FHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 00:07:22 -0500
Message-ID: <4248E282.1000105@nortel.com>
Date: Mon, 28 Mar 2005 23:07:14 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: krishna <krishna.c@globaledgesoft.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to measure time accurately.
References: <424779F3.5000306@globaledgesoft.com>
In-Reply-To: <424779F3.5000306@globaledgesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

krishna wrote:
> Hi All,
> 
> Can any one tell me how to measure time accurately for a block of C code 
> in device drivers.
> For example, If I want to measure the time duration of firmware download.

Most cpus have some way of getting at a counter or decrementer of 
various frequencies.  Usually it requires low-level hardware knowledge 
and often it needs assembly code.


On ppc you'd use the mftbu/mftbl instructions, as suggested by Lee on 
x86 you'd use the rdtsc instruction.

Chris
