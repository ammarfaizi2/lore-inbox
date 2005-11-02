Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbVKBPc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbVKBPc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 10:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbVKBPc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 10:32:56 -0500
Received: from [81.2.110.250] ([81.2.110.250]:32147 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S965076AbVKBPcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 10:32:55 -0500
Subject: Re: PATCH: EDAC - clean up atomic stuff
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       dthompson@lnxi.com
In-Reply-To: <20051102162653.4f0b8054.akpm@osdl.org>
References: <1129902050.26367.50.camel@localhost.localdomain>
	 <m164rhbnyk.fsf@ebiederm.dsl.xmission.com>
	 <1130772628.9145.35.camel@localhost.localdomain>
	 <m1oe55abm4.fsf@ebiederm.dsl.xmission.com>
	 <20051031120254.4579dc9a.akpm@osdl.org>
	 <m18xw88thu.fsf@ebiederm.dsl.xmission.com>
	 <20051102162653.4f0b8054.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Nov 2005 16:02:45 +0000
Message-Id: <1130947366.2432.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-11-02 at 16:26 +1100, Andrew Morton wrote:
> Well if we retain KM_BOUNCE_READ then we'll need local_irq_save().  If
> edac_mc_scrub_block() will alwyas be called from process context then we
> can use KM_USER0 and leave interrupts enabled.
> 
> Alan, can you confirm please?

Probably best to local_irq_save. Especially considering the likely
direction of updates once it is merged

Alan

