Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751694AbWGZPFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbWGZPFM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 11:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWGZPFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 11:05:12 -0400
Received: from ns2.suse.de ([195.135.220.15]:58312 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750789AbWGZPFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 11:05:10 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Edgar Hucek <hostmaster@ed-soft.at>, ebiederm@xmission.com, hpa@zytor.com,
       linux-kernel@vger.kernel.org, gregkh@suse.de, akpm@osdl.org
Subject: Re: [PATCH 1/1] Add force of use MMCONFIG [try #1]
References: <44A04F5F.8030405@ed-soft.at>
	<Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>
	<44A0CCEA.7030309@ed-soft.at>
	<Pine.LNX.4.64.0606262318341.3927@g5.osdl.org>
	<44A304C1.2050304@zytor.com>
	<m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com>
	<44A8058D.3030905@zytor.com>
	<m11wt3983j.fsf@ebiederm.dsl.xmission.com>
	<44AB8878.7010203@ed-soft.at>
	<m1lkr83v73.fsf@ebiederm.dsl.xmission.com>
	<44B6BF2F.6030401@ed-soft.at>
	<Pine.LNX.4.64.0607131507220.5623@g5.osdl.org>
	<44B73791.9080601@ed-soft.at>
	<Pine.LNX.4.64.0607140901200.5623@g5.osdl.org>
	<44BA0025.6020105@ed-soft.at> <20060724213339.2646435c.akpm@osdl.org>
	<Pine.LNX.4.64.0607242226200.29649@g5.osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 26 Jul 2006 17:05:00 +0200
In-Reply-To: <Pine.LNX.4.64.0607242226200.29649@g5.osdl.org>
Message-ID: <p73k6605rvn.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 24 Jul 2006, Andrew Morton wrote:
> > 
> > Why do we want to do this?  Are the ACPI-provided tables incorrect?  If so,
> > what problems are caused by this?
> 
> The ACPI-provided tables are apparently correct, but we sanity-check them 
> by _also_ requiring that the mmconfig base address is marked "reserved" in 
> the e820 tables.
> 
> The EFI memory maps apparently don't do that "reserved" marking.

We were planning to remove that heuristic anyways because it produced
far too many false positivies. In fact I think Greg has already 
done it. Then that patch should be obsolete.

-Andi
