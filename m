Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbTGBHiq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 03:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbTGBHiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 03:38:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29450 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261428AbTGBHip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 03:38:45 -0400
Date: Wed, 2 Jul 2003 08:53:02 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Bernardo Innocenti <bernie@develer.com>, Ian Molton <spyro@f2s.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
Message-ID: <20030702085302.A30638@flint.arm.linux.org.uk>
Mail-Followup-To: Bernardo Innocenti <bernie@develer.com>,
	Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <200307020232.20726.bernie@develer.com> <200307020424.47629.bernie@develer.com> <20030701193250.1cbd4af9.akpm@digeo.com> <200307020515.17722.bernie@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307020515.17722.bernie@develer.com>; from bernie@develer.com on Wed, Jul 02, 2003 at 05:15:17AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 05:15:17AM +0200, Bernardo Innocenti wrote:
> What's worse, it has different semantics on different architectures:

Any arch which does 32/32 -> 32q + 32r will break in the new time code;
it certainly did for ARM.  do_div must now be a 64/32 -> 64q + 32r
implementation.

>  arm       64/32 -> 64q + 32r (asm function call)
>  arm26     32/32 -> 32q + 32r (generic)

arm26 needs fixing in the same way arm recently was.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

