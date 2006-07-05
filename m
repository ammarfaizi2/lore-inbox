Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWGEPu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWGEPu5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 11:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWGEPu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 11:50:57 -0400
Received: from mga03.intel.com ([143.182.124.21]:52612 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932420AbWGEPu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 11:50:56 -0400
X-IronPort-AV: i="4.06,210,1149490800"; 
   d="scan'208"; a="61548760:sNHT7532973791"
Message-ID: <44ABDF87.8000801@intel.com>
Date: Wed, 05 Jul 2006 08:49:27 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.4 (X11/20060617)
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
CC: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>, akpm@osdl.org,
       LKML <linux-kernel@vger.kernel.org>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       netdev@vger.kernel.org
Subject: Re: [PATCH] ixgb: add PCI Error recovery callbacks
References: <20060629162634.GC5472@austin.ibm.com> <1151905766.28493.129.camel@ymzhang-perf.sh.intel.com>
In-Reply-To: <1151905766.28493.129.camel@ymzhang-perf.sh.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jul 2006 15:50:18.0685 (UTC) FILETIME=[B71DDED0:01C6A04A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zhang, Yanmin wrote:
> On Fri, 2006-06-30 at 00:26, Linas Vepstas wrote:
>> Adds PCI Error recovery callbacks to the Intel 10-gigabit ethernet
>> ixgb device driver. Lightly tested, works.
>
> Both pci_disable_device and ixgb_down would access the device. It doesn't
> follow Documentation/pci-error-recovery.txt that error_detected shouldn't do
> any access to the device.

Moreover, it was Linas who wrote this documentation in the first place :)

Linas, have you tried moving the e1000_down() call into the _reset part? I 
suspect that the e1000_reset() in there however may already be sufficient.

Cheers,

Auke
