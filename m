Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263809AbUDNGaf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 02:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263919AbUDNGaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 02:30:35 -0400
Received: from mail.shareable.org ([81.29.64.88]:65183 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263809AbUDNGae
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 02:30:34 -0400
Date: Wed, 14 Apr 2004 07:30:17 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ross Dickson <ross@datscreative.com.au>
Cc: Len Brown <len.brown@intel.com>, christian.kroener@tu-harburg.de,
       linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: IO-APIC on nforce2 [PATCH]
Message-ID: <20040414063017.GA7790@mail.shareable.org>
References: <200404131117.31306.ross@datscreative.com.au> <200404131703.09572.ross@datscreative.com.au> <1081893978.2251.653.camel@dhcppc4> <200404141502.14023.ross@datscreative.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404141502.14023.ross@datscreative.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Dickson wrote:
> The clock skew is an interesting one, I think the clock uses tsc if available
> to interpolate between timer ints and if so should it not also be used to 
> validate the timer ints in case of noise? Apparently the clock speeds up not
> slows down in those cases?

If the clock is speeding up due to spurious extra timer interrupts,
how about reading the timer chip to validate the interrupts?  Doesn't
sound unreasonable to me :)

The problem with using the tsc is that the tsc frequency isn't
constant on some systems.  If it slows down, it would make valid timer
interrupts appear to be spurious.

-- Jamie
