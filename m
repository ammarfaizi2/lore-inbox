Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275011AbTHLE4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 00:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275020AbTHLE4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 00:56:45 -0400
Received: from harlech.math.ucla.edu ([128.97.4.250]:36529 "EHLO
	harlech.math.ucla.edu") by vger.kernel.org with ESMTP
	id S275011AbTHLE4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 00:56:44 -0400
Date: Mon, 11 Aug 2003 21:56:43 -0700 (PDT)
From: Jim Carter <jimc@math.ucla.edu>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: NAT + IPsec in 2.6.0-test2
In-Reply-To: <1060662905.1840.103.camel@iso-8590-lx.zeusinc.com>
Message-ID: <Pine.LNX.4.53.0308112150430.4824@xena.cft.ca.us>
References: <1060662905.1840.103.camel@iso-8590-lx.zeusinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2003, Tom Sightler wrote:

> OK, I finally got racoon to work and have IPsec working great with a
> 2.6.0-test2-mm1 kernel on my home Internet gateway system.  However,
--snip--
> I've got the identical setup with kernel 2.6 and racoon.  I get the
> tunnel up and everything works great from the gateway system, but none
> of the systems on my home network can access the systems on the work
> network.  It seems that packets passing via IPsec are bypassing the NAT
> rules, although that's mostly just a guess at this point.

Could it be that the *name* of the ipsec device has changed?  Messing with
vtun, I did that to myself recently and suffered a similar loss of
connectivity through the tunnel.  My solution was an iptables rule saying
that packets going to any interface except the house network get NATted.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
