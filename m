Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbVHaOke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVHaOke (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 10:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbVHaOke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 10:40:34 -0400
Received: from mail.suse.de ([195.135.220.2]:60130 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932348AbVHaOkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 10:40:33 -0400
From: Andi Kleen <ak@suse.de>
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Subject: Re: APIC version and 8-bit APIC IDs
Date: Wed, 31 Aug 2005 16:40:27 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org,
       "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel> <p73pssj2xdz.fsf@verdi.suse.de> <4315AD07.2020500@fujitsu-siemens.com>
In-Reply-To: <4315AD07.2020500@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508311640.27795.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 August 2005 15:13, Martin Wilck wrote:

> In other words: What would be broken if we just used an APIC ID mask of
> 0xFF everywhere?

Nothing I think. It's more historical reasons. The physflat subarchitecture 
patch essentially removed it, but it needs some rework and merging
with bigsmp now.

> The current situation with MP_valid_apicid() on the one hand (masking
> the APIC ID as a function of local APIC version) and APIC_ID_MASK
> (masking the APIC as a function of subarch) on the other hand is
> inconsistent. A correct approach must take both CPU and architecture
> constraints into account, and use a CPU-type-dependent variable mask in
> the subarch code.

Yes, it's broken right now.

-Andi
