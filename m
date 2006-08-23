Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWHWJuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWHWJuY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 05:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWHWJuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 05:50:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:40148 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751505AbWHWJuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 05:50:21 -0400
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] paravirt.h
Date: Wed, 23 Aug 2006 11:50:17 +0200
User-Agent: KMail/1.9.3
Cc: Arjan van de Ven <arjan@infradead.org>, virtualization@lists.osdl.org,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1155202505.18420.5.camel@localhost.localdomain> <200608231141.37284.ak@suse.de> <44EC2450.3060706@vmware.com>
In-Reply-To: <44EC2450.3060706@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608231150.17650.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> And the functions they call?

Yes. But you only really need it for the actual callback, not the bulk
of stop_machine_run() (which calls scheduler and lots of other stuff)
The actual callback should be pretty limited already so it shouldn't
be a big limitation.

-Andi
