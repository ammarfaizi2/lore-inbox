Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752629AbWKFTTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbWKFTTK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 14:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752633AbWKFTTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 14:19:09 -0500
Received: from mga07.intel.com ([143.182.124.22]:53311 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1752629AbWKFTTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 14:19:07 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,392,1157353200"; 
   d="scan'208"; a="142018018:sNHT56947275"
Message-ID: <454F8AA3.5080209@linux.intel.com>
Date: Mon, 06 Nov 2006 20:18:59 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, shaohua.li@intel.com, bunk@stusta.de
Subject: Re: [patch] Regression in 2.6.19-rc microcode driver
References: <1162822538.3138.28.camel@laptopd505.fenrus.org> <20061106110152.63ef91bc.akpm@osdl.org>
In-Reply-To: <20061106110152.63ef91bc.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Can we fix this by switching to late_initcall() or something like that?

after testing this: the answer is "no." ;(

at least not without significant redesign on how this all interacts 
(which includes cpuhotplug meeting sysfs which isn't all that pretty 
already) which is imo not a 2.6.19 thing.
