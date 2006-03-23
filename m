Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbWCWTC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbWCWTC2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 14:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWCWTC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 14:02:28 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:14734 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932563AbWCWTC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 14:02:27 -0500
Subject: Re: [patch] Ignore MCFG if the mmconfig area isn't reserved in the
	e820 table
From: Arjan van de Ven <arjan@linux.intel.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <200603231856.12227.ak@suse.de>
References: <1143138170.3147.43.camel@laptopd505.fenrus.org>
	 <200603231856.12227.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Mar 2006 20:02:18 +0100
Message-Id: <1143140539.3147.44.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That is e820_mapped(address, address+size, E820_RESERVED)
> 
> And not having a size is definitely wrong on i386 too.

s/wrong/not selective enough/

and e820_mapped doesn't check this either anyway, at least not the way
you imply it does.

I'll do a new patch using this for x86_64 though, no need to make a
second function like this.

