Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbTBTMV5>; Thu, 20 Feb 2003 07:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbTBTMVU>; Thu, 20 Feb 2003 07:21:20 -0500
Received: from holomorphy.com ([66.224.33.161]:32414 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265270AbTBTMU2>;
	Thu, 20 Feb 2003 07:20:28 -0500
Date: Thu, 20 Feb 2003 04:29:34 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix kirq code for clustered mode
Message-ID: <20030220122934.GA29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
References: <3E5272A0.80803@us.ibm.com> <20030220121917.GZ29983@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220121917.GZ29983@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 09:51:28AM -0800, Dave Hansen wrote:
>> The new kirq code breaks clustered apic mode.  This 2-liner fixes it.
>> It should compile down to the same thing, unless you're using a
>> clustered apic sub-arch.

On Thu, Feb 20, 2003 at 04:19:17AM -0800, William Lee Irwin III wrote:
> This isn't quite enough:

Also, even with your patch, I get:

Uhhuh. NMI received for unknown reason 25 on CPU 3.
Uhhuh. NMI received for unknown reason 35 on CPU 2.
Dazed and confused, but trying to continue
...

Hmm... something is going seriously wrong here. I suspect someone
is clobbering my RTE's even though no_irq_balance is #defined to 1.
Or, worse yet, NMI interrupt gate boogie is going seriously wrong.


-- wli
