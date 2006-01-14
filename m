Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932740AbWANGs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932740AbWANGs2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 01:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932745AbWANGs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 01:48:27 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:15053 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932769AbWANGs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 01:48:26 -0500
Date: Sat, 14 Jan 2006 07:48:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Miroslaw Mieszczak <mirek@mieszczak.com.pl>, linux-kernel@vger.kernel.org,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Seth, Rohit" <rohit.seth@intel.com>
Subject: Re: [2.6] Problem with PDC20265 on system with I865 chipset and PIV HT
Message-ID: <20060114064836.GB9699@elte.hu>
References: <43C6DA9D.4060300@mieszczak.com.pl> <20060113001618.66821fcb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113001618.66821fcb.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.1 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> That's oopsing when trying to write to the APIC:
> 
> 	apic_write_around(APIC_EOI, 0);
> 
> <cc's x86 people>
> 
> Is there any sane way in which APIC accesses can fault, or does this 
> indicate bad hardware?

no - the local APIC in that context is like ordinary memory. If there's  
fault, it must be the pagetables.

perhaps the "data corruption and system crash" mentioned in the report 
corrupted kernel pagetables?

	Ingo
