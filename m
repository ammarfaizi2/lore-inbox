Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUHBStO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUHBStO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 14:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUHBStN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 14:49:13 -0400
Received: from jade.spiritone.com ([216.99.193.136]:49851 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S261426AbUHBStM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 14:49:12 -0400
Date: Mon, 02 Aug 2004 11:49:02 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: jmoyer@redhat.com, Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: finding out the boot cpu number from userspace
Message-ID: <35890000.1091472541@[10.10.2.4]>
In-Reply-To: <1091468548.810.3.camel@localhost.localdomain>
References: <20040802121635.GE14477@devserv.devel.redhat.com> <12690000.1091461852@[10.10.2.4]> <16654.29342.977105.723775@segfault.boston.redhat.com> <30660000.1091467382@[10.10.2.4]> <1091468548.810.3.camel@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Eric went to some lengths to migrate us back to the original boot CPU 
>> before kexec'ing. I think this is unnecessary - the new kernel should
>> handle booting on any CPU just fine (there was a panic in there at one
>> point if the boot CPU didn't match the BIOS's spec'ed one, but I removed
>> it).
> 
> Several systems have broken SMM or BIOS functionality that requires the
> *real* boot processor is used. The panic was correct and should be
> restored. See apm_power_off() for one example.

Ah, OK didn't know that ... however, I'm not convinced that panicing is 
really that useful ... what happens if you proceed? IIRC, this is before 
console_init as well, so people won't even see the error. At least it 
should only do that on machines that are borked in such a fashion - 99% of 
machines will work fine, AFAICS.

M.

