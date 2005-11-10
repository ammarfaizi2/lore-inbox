Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbVKJOCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbVKJOCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbVKJOBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:01:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:28610 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750898AbVKJOBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:01:23 -0500
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH 25/39] NLKD/x86-64 - core
Date: Thu, 10 Nov 2005 14:30:47 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <43720DAE.76F0.0078.0@novell.com> <4372138D.76F0.0078.0@novell.com> <437213E0.76F0.0078.0@novell.com>
In-Reply-To: <437213E0.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511101430.47757.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 November 2005 15:21, Jan Beulich wrote:
> The core x86-64 NLKD additions.

I probably won't merge that unless the full NLKD somehow manages to get 
into mainline. Shouldn't be that hard to maintain out of tree or even
build the debugger in a fully separate directory.

My general suggestion would be to move away from using your own
defines for all the architecture state (MSRs etc) but instead use
the ones from the Linux headers instead which should be largely
equivalent (if there are some missing we can probably add them) 
And getting of that Intel style assembly would be good too.

I would move the asm-offset bits into a separate file, perhaps run from
the NLKD Makefile, that should reduce later merging pain.

-Andi
