Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVHPXmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVHPXmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVHPXmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:42:14 -0400
Received: from cantor2.suse.de ([195.135.220.15]:12166 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750700AbVHPXmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:42:13 -0400
Date: Wed, 17 Aug 2005 01:42:05 +0200
From: Andi Kleen <ak@suse.de>
To: zach@vmware.com
Cc: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zwame@arm.linux.org.uk
Subject: Re: [PATCH 4/14] i386 / Clean up asm and volatile keywords in desc
Message-ID: <20050816234205.GE27628@wotan.suse.de>
References: <200508110453.j7B4rpe9019530@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508110453.j7B4rpe9019530@zach-dev.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 09:53:51PM -0700, zach@vmware.com wrote:
> Stop using extra underscores on asm and volatiles, that is just silly.

Actually the volatiles might be still useful. Or if you drop them
at least add memory clobbers. I had sometimes bugs  on x86-64
with the compiler moving such assembly statements with invisible 
side effects around too aggressively and causing weird problems.

Agreed on the underscores, I hate them too :)

-Andi
