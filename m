Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965258AbVIIFTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965258AbVIIFTt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 01:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965260AbVIIFTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 01:19:49 -0400
Received: from birao.terra.com.br ([200.176.10.197]:64450 "EHLO
	birao.terra.com.br") by vger.kernel.org with ESMTP id S965258AbVIIFTs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 01:19:48 -0400
X-Terra-Karma: -2%
X-Terra-Hash: 29d5af0c8c3de85093f2518d3dfc5ffa
Message-ID: <43211B67.30607@terra.com.br>
Date: Fri, 09 Sep 2005 02:19:35 -0300
From: Piter PUNK <piterpk@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050731
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.13] x86: check host bridge when applying vendor quirks
References: <200509082236_MC3-1-A99D-81DD@compuserve.com> <200509090447.10118.ak@suse.de>
In-Reply-To: <200509090447.10118.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Friday 09 September 2005 04:33, Chuck Ebbert wrote:
> 
>>I was looking at the i386 ACPI early quirk code and x86_64 equivalent
>>and it seems to me it should be checking the host bridge vendor, not
>>the one for various PCI bridges.  Nvidia might release some kind of
>>PCI card with an embedded bridge that would break this code, for
>>example.  I made this patch but I can't test it:
> 
> It's wrong. On AMD K8 systems the host bridge is always from
> AMD because the Northbridge is part of the CPU.

Hmmm... no.

root@Weasley:/etc# lspci
00:00.0 Host bridge: ATI Technologies Inc: Unknown device 5950
<...many things...>
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control

The Athlon64 machines has an external host bridge. You can look the
ATI Host Bridge in the first line of lspci.

Piter PUNK
