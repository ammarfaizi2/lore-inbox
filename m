Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264025AbUDGSIj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 14:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264079AbUDGSIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 14:08:38 -0400
Received: from colin2.muc.de ([193.149.48.15]:18194 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264025AbUDGSIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 14:08:37 -0400
Date: 7 Apr 2004 20:08:35 +0200
Date: Wed, 7 Apr 2004 20:08:35 +0200
From: Andi Kleen <ak@muc.de>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Andi Kleen <ak@muc.de>, Paul Wagland <paul@wagland.net>,
       linux-kernel@vger.kernel.org, gktnews@gktech.net
Subject: Re: amd64 questions
Message-ID: <20040407180835.GA52759@colin2.muc.de>
References: <1Ijzw-4ff-5@gated-at.bofh.it> <1Ijzv-4ff-3@gated-at.bofh.it> <1IntE-7wn-39@gated-at.bofh.it> <m3isgb69xx.fsf@averell.firstfloor.org> <40743110.8000306@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40743110.8000306@nortelnetworks.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 12:49:20PM -0400, Chris Friesen wrote:
> Andi Kleen wrote:
> 
> >The problem is always the long long alignment. AMD64/IA64 have different
> >alignment for long long than i386. The emulation was originally tested
> >on some RISC port, where the alignment is the same.
> 
> What about a compiler flag to emit i386 code with the more strenuous 
> long long alignment?

That would break other things, glibc uses long long heavily too. 
The only simple way would be to add the necessary alignment by hand and 
create a special 32bit on 64bit kernel iptables or ipsec.

-Andi
