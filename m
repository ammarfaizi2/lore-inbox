Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422901AbWBAToY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422901AbWBAToY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 14:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422903AbWBAToY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 14:44:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55014 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422901AbWBAToX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 14:44:23 -0500
Date: Wed, 1 Feb 2006 14:44:00 -0500
From: Dave Jones <davej@redhat.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AMD64: fix mce_cpu_quirks typos
Message-ID: <20060201194400.GB21132@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Florian Weimer <fw@deneb.enyo.de>, linux-kernel@vger.kernel.org
References: <87fyn2yjpr.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fyn2yjpr.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 08:14:56PM +0100, Florian Weimer wrote:
 > The spurious MCE is TLB-related.  I *think* the bit for the correct
 > status code is stored at position 10 HEX, not 10 DEC

not true.   According to the BIOS writer guide, it's bit 10.
The register only defines bits up to bit 12

Your patch makes it poke a reserved part of the register, which
is definitly undesired.

		Dave

