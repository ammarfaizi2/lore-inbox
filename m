Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422668AbWBCS6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422668AbWBCS6M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422659AbWBCS6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:58:12 -0500
Received: from mail.dvmed.net ([216.237.124.58]:5060 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422639AbWBCS6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:58:09 -0500
Message-ID: <43E3A7B8.2050607@pobox.com>
Date: Fri, 03 Feb 2006 13:58:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Chris Leech <christopher.leech@intel.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [RFC][PATCH 000 of 3] MD Acceleration and the ADMA interface:
 Introduction
References: <1138931168.6620.8.camel@dwillia2-linux.ch.intel.com> <43E39F2B.5080408@drzeus.cx>
In-Reply-To: <43E39F2B.5080408@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Pierre Ossman wrote: > Dan Williams wrote: > >>The ADMA
	(Asynchronous / Application Specific DMA) interface is proposed >>as a
	cross platform mechanism for supporting system CPU offload engines.
	>>The goal is to provide a unified asynchronous interface to support
	>>memory copies, block xor, block pattern setting, block compare, CRC
	>>calculation, cryptography etc. The ADMA interface should support a
	PIO >>fallback mode allowing a given ADMA engine implementation to use
	the >>system CPU for operations without a hardware accelerated backend.
	In >>other words a client coded to the ADMA interface transparently
	receives >>hardware acceleration for its operations depending on the
	features of >>the underlying platform. >> > > > I'm wondering, how
	common is this ADMA acronym? I've been writing a MMC [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> Dan Williams wrote:
> 
>>The ADMA (Asynchronous / Application Specific DMA) interface is proposed
>>as a cross platform mechanism for supporting system CPU offload engines.
>>The goal is to provide a unified asynchronous interface to support
>>memory copies, block xor, block pattern setting, block compare, CRC
>>calculation, cryptography etc.  The ADMA interface should support a PIO
>>fallback mode allowing a given ADMA engine implementation to use the
>>system CPU for operations without a hardware accelerated backend.  In
>>other words a client coded to the ADMA interface transparently receives
>>hardware acceleration for its operations depending on the features of
>>the underlying platform.
>>
> 
> 
> I'm wondering, how common is this ADMA acronym? I've been writing a MMC

In ATA land, ADMA is a hardware ATA controller interface, similar to 
AHCI.  We even have a pdc_adma (Pacific Digital ADMA) driver in the 
tree, and NVIDIA uses a variant of the ADMA interface in their SATA 
controllers.

	Jeff



