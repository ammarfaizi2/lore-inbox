Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbUCJWFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 17:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbUCJWFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 17:05:38 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:10486 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262855AbUCJWFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 17:05:31 -0500
Subject: Re: [PATCH] 2.6.x BSD Process Accounting w/High UID
From: Albert Cahalan <albert@users.sf.net>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       corliss@digitalmages.com, riel@redhat.com, jerj@coplanar.net
In-Reply-To: <Pine.LNX.4.53.0403101844140.15085@gockel.physik3.uni-rostock.de>
References: <1078883951.2232.501.camel@cube>
	 <Pine.LNX.4.53.0403100940240.12833@gockel.physik3.uni-rostock.de>
	 <1078936898.2232.571.camel@cube>
	 <Pine.LNX.4.53.0403101844140.15085@gockel.physik3.uni-rostock.de>
Content-Type: text/plain
Organization: 
Message-Id: <1078956556.2233.586.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Mar 2004 17:09:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-10 at 12:47, Tim Schmielau wrote:
> On Wed, 10 Mar 2004, Albert Cahalan wrote:
> 
> > That's a 42-bit number instead of a 36-bit one.
> 
> OK, your format clearly wins. Especially since I think that comp_t can
> only encode a 34-bit number.

That is correct. 42 - 8 != 36

My diagram was right; the math was not.

> But I favor your suggestion of 32-bit IEEE floats even more,
> as it doesn't need a change to the GNU acct tools.

I'm surprised. Do the tools rely on a #define for this?

Is there a reason to have the whole struct be a
power of two? If so, and you don't wish to expand
it to 128 bytes, consider packing 3 80-byte records
and a 16-byte header into 256 bytes.


