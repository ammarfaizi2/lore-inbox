Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVAISkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVAISkJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 13:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVAISkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 13:40:09 -0500
Received: from colin2.muc.de ([193.149.48.15]:24078 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261674AbVAISkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 13:40:06 -0500
Date: 9 Jan 2005 19:40:05 +0100
Date: Sun, 9 Jan 2005 19:40:05 +0100
From: Andi Kleen <ak@muc.de>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: Notify user of MCE events (updated)
Message-ID: <20050109184005.GA37583@muc.de>
References: <Pine.LNX.4.61.0501082121380.13639@montezuma.fsmlabs.com> <m1sm5av9fd.fsf@muc.de> <Pine.LNX.4.61.0501091005590.13639@montezuma.fsmlabs.com> <m1fz1av5am.fsf@muc.de> <41E17860.1040100@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E17860.1040100@domdv.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2005 at 07:30:56PM +0100, Andreas Steinmetz wrote:
> Just asking:
> How about KERN_NOTICE? KERN_INFO is in my opinion too easily lost in the 

It's still in the mcelog if you want it.

The main idea behind the separate mcelog was to make it unobstrusive to 
reduce MCE related support load. (about 20% of all users who get such a 
message seem to think it's a kernel bug and ask kernel developers) 
KERN_INFO is at the right level of unintrusiveness.

-Andi
