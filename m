Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946378AbWKAFyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946378AbWKAFyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946529AbWKAFyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:54:46 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:52114 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1946534AbWKAFyl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:54:41 -0500
Date: Wed, 1 Nov 2006 07:54:35 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ernst Herzberg <earny@net4u.de>, Len Brown <lenb@kernel.org>,
       Adrian Bunk <bunk@stusta.de>, Hugh Dickins <hugh@veritas.com>,
       Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       Martin Lorenz <martin@lorenz.eu.org>, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.19-rc <-> ThinkPads
Message-ID: <20061101055435.GB4933@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Linus Torvalds <torvalds@osdl.org>:
> Subject: Re: 2.6.19-rc <-> ThinkPads
> 
> 
> 
> On Wed, 1 Nov 2006, Ernst Herzberg wrote:
> > 
> > still bisecting, will report the result.
> 
> Figuring out what caused an apparent change of behaviour is definitely a 
> good idea - it might give us some clue to what really is going on.

I've been bisecting ACPI/suspend thinkpad issue myself and I seem to get
eea0e11c1f0d6ef89e64182b2f1223a4ca2b74a2 good,
cf4c6a2f27f5db810b69dcb1da7f194489e8ff88 bad.

At least this makes some sense since the log speaks about suspend.  Problem is,
ACPI issues are in rare cases going away for a while for me so this needs more
testing before I can say for sure about the good part - I already had one false
negative.  What I plan to do is using eea0e11c1f0d6ef89e64182b2f1223a4ca2b74a2
for a couple of days and see how this works out.

-- 
MST
