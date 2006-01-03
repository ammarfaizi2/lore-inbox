Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbWACXuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbWACXuQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbWACXtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:49:31 -0500
Received: from ns2.suse.de ([195.135.220.15]:40871 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965015AbWACXtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:49:12 -0500
From: Andi Kleen <ak@suse.de>
To: Jason Uhlenkott <jasonuhl@sgi.com>
Subject: Re: [PATCH] x86_64: fix IRQ vector reservations
Date: Wed, 4 Jan 2006 00:49:54 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <20060103233544.GA393161@dragonfly.engr.sgi.com>
In-Reply-To: <20060103233544.GA393161@dragonfly.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601040049.54873.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 00:35, Jason Uhlenkott wrote:
> It looks like the new scalable TLB flush code for x86_64 is claiming
> one more IRQ vector than it actually uses.

Thanks for noticing - you seem to have sharper eyes than me.

Should probably free the KDB vector too since it's totally useless
(it's an NMI and NMIs always get delivered to vector NMI_VECTOR)

-Andi
