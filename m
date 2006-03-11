Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752275AbWCKAkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbWCKAkF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 19:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbWCKAkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 19:40:05 -0500
Received: from hera.kernel.org ([140.211.167.34]:47562 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1752275AbWCKAkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 19:40:03 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Router stops routing after changing MAC Address
Date: Fri, 10 Mar 2006 16:39:58 -0800
Organization: OSDL
Message-ID: <20060310163958.1215b0c4@localhost.localdomain>
References: <925A849792280C4E80C5461017A4B8A20321CC@mail733.InfraSupportEtc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1142037598 31403 10.8.0.54 (11 Mar 2006 00:39:58 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Sat, 11 Mar 2006 00:39:58 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2006 18:33:15 -0600
"Greg Scott" <GregScott@InfraSupportEtc.com> wrote:

> Hello - This feels like a kernel issue.  I spent hours and hours and
> hours looking for documentation and archives around this but did not
> find anything.  
> 
> I have a Linux router and I need the ability to swap hardware without
> causing downtime.  The problem, of course, is ARPs.  The NICs in the
> replacement system need the same MAC Addresses as the NICs in the
> original system.  I'd like this all to be in the kernel and not depend
> on a daemon process that can die.
> 
> How to change MAC addresses is documented well enough - and it works -
> but when I change MAC addresses, my router stops routing.  From the
> router, I can see the systems on both sides - but the router just
> refuses to forward packets.  Here are my little test scripts to change
> MAC Addresses.

You probably just need to flush the route cache after the address change?
