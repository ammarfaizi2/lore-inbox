Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263050AbVGNQCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbVGNQCi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 12:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbVGNQCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 12:02:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21165 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263050AbVGNQCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 12:02:37 -0400
Subject: Re: [rfc patch 2/2] direct-io: remove address alignment check
From: Daniel McNeil <daniel@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <p73hdex5xws.fsf@bragg.suse.de>
References: <1121298112.6025.21.camel@ibm-c.pdx.osdl.net.suse.lists.linux.kernel>
	 <p73hdex5xws.fsf@bragg.suse.de>
Content-Type: text/plain
Message-Id: <1121356952.6025.33.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 14 Jul 2005 09:02:32 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 06:18, Andi Kleen wrote:
> Daniel McNeil <daniel@osdl.org> writes:
> 
> > This patch relaxes the direct i/o alignment check so that user addresses
> > do not have to be a multiple of the device block size.
> 
> The original reason for this limit was that lots of drivers
> (not only IDE) explode when you give them odd sizes. Sometimes
> it is even worse.
> 
> I doubt all of them have been fixed.
> 
> Very risky change.
> 

That is exactly why I made this a separate patch, so that we
can test and find out where the problems are and work to fix
them.

Are there problems only with odd sizes, or do drivers have problems
with non-512 sizes?

Allowing 4-byte aligned user addresses would be a good step
forward, since it looks like malloc() returns 4-byte aligned 
addresses.

Daniel

