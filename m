Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbTDPObh (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 10:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTDPObh 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 10:31:37 -0400
Received: from zero.aec.at ([193.170.194.10]:50948 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264388AbTDPObg 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 10:31:36 -0400
Date: Wed, 16 Apr 2003 16:43:12 +0200
From: Andi Kleen <ak@muc.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@muc.de, akpm@digeo.com, linux-kernel@vger.kernel.org, anton@samba.org,
       schwidefsky@de.ibm.com, davidm@hpl.hp.com, matthew@wil.cx,
       ralf@linux-mips.org, rth@redhat.com
Subject: Re: Reduce struct page by 8 bytes on 64bit
Message-ID: <20030416144312.GA2327@averell>
References: <20030415112430.GA21072@averell> <20030416.054521.26525548.davem@redhat.com> <20030416140715.GA2159@averell> <20030416.072638.65480350.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030416.072638.65480350.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 04:26:38PM +0200, David S. Miller wrote:
>    From: Andi Kleen <ak@muc.de>
>    Date: Wed, 16 Apr 2003 16:07:15 +0200
> 
>    How so? Of course I could write an generic set_bit32, but the question
>    is if these bit operations would be still atomic on SMP and not conflict with
>    fields occuping the same 8 byte slot. I remember you flaming someone 
>    some time ago because he used set_bit in an atomic fashion on a type smaller
>    than unsigned long for example.
> 
> It's OK if you align the pointer to 8 bytes, and subsequently the bit
> offset as appropriate. :-)

On sparc64. But is that true too for all other 64bit architectures supported?

e.g. How about PA-RISC? (always seems to do things differently)

-Andi
