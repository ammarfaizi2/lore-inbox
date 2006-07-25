Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWGYF1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWGYF1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 01:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWGYF1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 01:27:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5266 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932462AbWGYF1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 01:27:21 -0400
Date: Mon, 24 Jul 2006 22:27:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Edgar Hucek <hostmaster@ed-soft.at>, ebiederm@xmission.com, hpa@zytor.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Add force of use MMCONFIG [try #1]
In-Reply-To: <20060724213339.2646435c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0607242226200.29649@g5.osdl.org>
References: <44A04F5F.8030405@ed-soft.at> <Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>
 <44A0CCEA.7030309@ed-soft.at> <Pine.LNX.4.64.0606262318341.3927@g5.osdl.org>
 <44A304C1.2050304@zytor.com> <m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com>
 <44A8058D.3030905@zytor.com> <m11wt3983j.fsf@ebiederm.dsl.xmission.com>
 <44AB8878.7010203@ed-soft.at> <m1lkr83v73.fsf@ebiederm.dsl.xmission.com>
 <44B6BF2F.6030401@ed-soft.at> <Pine.LNX.4.64.0607131507220.5623@g5.osdl.org>
 <44B73791.9080601@ed-soft.at> <Pine.LNX.4.64.0607140901200.5623@g5.osdl.org>
 <44BA0025.6020105@ed-soft.at> <20060724213339.2646435c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Jul 2006, Andrew Morton wrote:
> 
> Why do we want to do this?  Are the ACPI-provided tables incorrect?  If so,
> what problems are caused by this?

The ACPI-provided tables are apparently correct, but we sanity-check them 
by _also_ requiring that the mmconfig base address is marked "reserved" in 
the e820 tables.

The EFI memory maps apparently don't do that "reserved" marking.

		Linus
