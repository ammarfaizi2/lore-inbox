Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVKMS7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVKMS7p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 13:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVKMS7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 13:59:44 -0500
Received: from mx1.suse.de ([195.135.220.2]:53917 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750819AbVKMS7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 13:59:44 -0500
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
Date: Sun, 13 Nov 2005 20:00:44 +0100
User-Agent: KMail/1.8.2
Cc: Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, torvalds@osdl.org
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com> <p734q6g4xuc.fsf@verdi.suse.de> <1131902775.25311.16.camel@localhost.localdomain>
In-Reply-To: <1131902775.25311.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511132000.45836.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 November 2005 18:26, Alan Cox wrote:

> I'd hope the vendors are not doing that by default because we have
> kernel code that uses lock against not other processors but other bus
> masters. The ECC code is one example. 

It's a bad hack anyways. Better would be probably to use a uncached WC write.
I would rather use that.

-Andi
