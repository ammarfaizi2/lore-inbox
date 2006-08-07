Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWHGNgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWHGNgq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 09:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWHGNgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 09:36:46 -0400
Received: from cantor2.suse.de ([195.135.220.15]:21973 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750951AbWHGNgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 09:36:45 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: notify_page_fault_chain
Date: Mon, 7 Aug 2006 15:36:40 +0200
User-Agent: KMail/1.9.3
Cc: anil.s.keshavamurthy@intel.com, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <44D75ACE.76E4.0078.0@novell.com>
In-Reply-To: <44D75ACE.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608071536.40303.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 15:22, Jan Beulich wrote:

> I just noticed this addition to i386 and x86-64, conditionalized upon CONFIG_KPROBES. May I ask what the motivation for
> this compatibility breaking change is?

It's normally policy to only care about in tree code regarding exports and hooks.
But also no policy without exceptions.

> Only performance?

Christopher L. complained about it taking too long on IA64 I think
(but that might have been some IA64 specific quirk)

I think I proposed to use a inline check of the chain and only then
call the external function, but that might not have been implemented
that way.

> I consider it already questionable to split out a specific  
> fault from the general die notification (previous users of the functionality all of the sudden won't get notifications
> for one of the most crucial faults anymore), but entirely hiding the functionality (unavailable without CONFIG_KPROBES,
> and even with it not getting exported) is really odd.

You want to use it for your debugger? 

-Andi
