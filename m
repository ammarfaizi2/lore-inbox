Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVCZOMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVCZOMe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 09:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVCZOMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 09:12:34 -0500
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:404 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S262097AbVCZOMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 09:12:15 -0500
Date: Sat, 26 Mar 2005 22:12:11 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matthew Collins <matt@signalz.com>, linux-kernel@vger.kernel.org
Subject: Re: Promise SX8 performance issues and CARM_MAX_Q
Message-ID: <20050326141210.GJ4300@blackham.com.au>
References: <20050323175707.GA10481@blackham.com.au> <4241F8BA.6070108@pobox.com> <4241FAF9.1080702@signalz.com> <42438EED.4020202@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42438EED.4020202@pobox.com>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 11:09:17PM -0500, Jeff Garzik wrote:
> The driver was developed on a pre-production board, so its entirely 
> possible Promise fixed this issue.
> 
> The driver should be solid for _at least_ CARM_MAX_Q==31, presuming that 
> the firmware doesn't choke.

Stressing this SX8 card broke with CARM_MAX_Q anything higher than
16. Tests included simultaneous iozones, bonnie++'s, fsx, badblocks,
and mkfs'ing, on 4 ports. Setting CARM_MAX_Q to 17 or above
resulted in errors such as:

Buffer I/O error on device sx80_0p1, logical block 108828
lost page write due to I/O error on sx80_0p1
end_request: I/O error, dev sx80_2, sector 389167

It's been thrashing away with various tests most of today with
CARM_MAX_Q = 16, and it hasn't missed a beat.

Thanks must go to Matt Johnston who actually did all the work of
giving the card and drives a hard time.

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>
