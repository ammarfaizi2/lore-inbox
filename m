Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbUCCUQe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 15:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbUCCUQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 15:16:33 -0500
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:17020 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261165AbUCCUQc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 15:16:32 -0500
Subject: Re: [RFC] syncppp broken - how to fix?
From: Paul Fulghum <paulkf@microgate.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040303114906.1a4027da@dell_ss3.pdx.osdl.net>
References: <1078341592.2118.19.camel@deimos.microgate.com>
	 <1078341865.2118.22.camel@deimos.microgate.com>
	 <20040303114906.1a4027da@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1078344984.2118.43.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Mar 2004 14:16:24 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-03 at 13:49, Stephen Hemminger wrote:
> That assert can go, it is a left over from the conversion
> of the wan devices to use alloc_netdev.

OK

> The whole ppp structure layering
> is a mess; with a bad case of assumed encapsulation.

Agreed, it is *really* ugly.

I've decided to alter the synclink drivers to
work with and without the new assertion. That
way, our customers can download updated
drivers from our web site which will work
with any 2.6 kernel.

Removing the assertion fixes things for the
other drivers starting with kernel 2.6.5

--
Paul Fulghum
paulkf@microgate.com


