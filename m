Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbVJMALj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbVJMALj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 20:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbVJMALj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 20:11:39 -0400
Received: from ns2.suse.de ([195.135.220.15]:30694 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964825AbVJMALi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 20:11:38 -0400
From: Andi Kleen <ak@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [discuss] [Patch 1/2] x86, x86_64: Intel HT, Multi core detection fixes
Date: Thu, 13 Oct 2005 02:10:22 +0200
User-Agent: KMail/1.8.2
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20051005161706.B30098@unix-os.sc.intel.com> <200510122349.05312.ak@suse.de> <20051012151926.E29292@unix-os.sc.intel.com>
In-Reply-To: <20051012151926.E29292@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510130210.23311.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 October 2005 00:19, Siddha, Suresh B wrote:

> x86_num_cores (cpuid returned value) is required while right shifting the 
> apicid to get the core-id and the package-id. booted_cores will indicate 
> how many cores actually cameup. x86_num_cores can differ from "booted cores" 
> in these scenarios

The original idea was to round it up to the next power of two 
before shifting. But I can see that it will break when the number
of online cores differs from the max number by more than a single power 
of two (e.g. quadcore with only a single CPU booted) 

Ok, if you rename the variable to make it clear

x86_num_cores -> x86_max_cores


-Andi
