Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269229AbUISMMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269229AbUISMMA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 08:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269230AbUISML7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 08:11:59 -0400
Received: from colin2.muc.de ([193.149.48.15]:7172 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S269229AbUISML6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 08:11:58 -0400
Date: 19 Sep 2004 14:11:55 +0200
Date: Sun, 19 Sep 2004 14:11:55 +0200
From: Andi Kleen <ak@muc.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       "David S. Miller" <davem@davemloft.net>, benh@kernel.crashing.org,
       wli@holomorphy.com, davem@redhat.com, raybry@sgi.com,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch V8: [4/7] universally available cmpxchg on i386
Message-ID: <20040919121155.GA58884@muc.de>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com> <B6E8046E1E28D34EB815A11AC8CA312902CD3243@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0409181627300.24054@schroedinger.engr.sgi.com> <200409191430.37444.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409191430.37444.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2004 at 02:30:37PM +0300, Denis Vlasenko wrote:
> Far too large for inline

It's much smaller than it looks - the switch will be optimized away by the
compiler. For the X86_CMPXCHG case it is even a single instruction.
For the other case it should be < 10 instructions, which is still reasonable.

-Andi
