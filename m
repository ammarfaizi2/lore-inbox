Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWJJXwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWJJXwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 19:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWJJXwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 19:52:45 -0400
Received: from mga07.intel.com ([143.182.124.22]:33194 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932284AbWJJXwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 19:52:44 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,291,1157353200"; 
   d="scan'208"; a="129378433:sNHT7438906972"
Message-ID: <452C3237.6010708@linux.intel.com>
Date: Wed, 11 Oct 2006 01:52:23 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Paul Dickson <paul@permanentmail.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jgarzik@pobox.com,
       akpm@osdl.org, mingo@elte.hu
Subject: Re: [patch 2/2] round_jiffies users
References: <1160496165.3000.308.camel@laptopd505.fenrus.org>	<1160496210.3000.310.camel@laptopd505.fenrus.org>	<1160496263.3000.312.camel@laptopd505.fenrus.org> <20061010154717.e2c4c149.paul@permanentmail.com>
In-Reply-To: <20061010154717.e2c4c149.paul@permanentmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Dickson wrote:
> On Tue, 10 Oct 2006 18:04:23 +0200, Arjan van de Ven wrote:
> 
>> +			mod_timer(&adapter->phy_info_timer, round_jiffies(jiffies + 2 * HZ));
> 
> Shouldn't round_jiffies_relative be used for some of these, a la:
> 
>   +			mod_timer(&adapter->phy_info_timer, round_jiffies_relative(2 * HZ));
> 

mod_timer() takes an absolute jiffies value as argument, so... no :)
