Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUEaWoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUEaWoJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 18:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264683AbUEaWoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 18:44:09 -0400
Received: from CPE-203-45-94-214.nsw.bigpond.net.au ([203.45.94.214]:5355 "EHLO
	mudlark.pw.nest") by vger.kernel.org with ESMTP id S264665AbUEaWoG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 18:44:06 -0400
Message-ID: <40BBB522.3030806@aurema.com>
Date: Tue, 01 Jun 2004 08:43:46 +1000
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michal Jaegermann <michal@harddata.com>
CC: Ian Kent <raven@themaw.net>, linux-kernel@vger.kernel.org
Subject: Re: How to use floating point in a module?
References: <200405310250.i4V2ork05673@mailout.despammed.com>	<Pine.LNX.4.58.0405311340450.4198@wombat.indigo.net.au> <20040531141253.A18246@mail.harddata.com>
In-Reply-To: <20040531141253.A18246@mail.harddata.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Jaegermann wrote:
> On Mon, May 31, 2004 at 01:44:40PM +0800, Ian Kent wrote:
> 
>>Why not scaled longs (or bigger), scalled to number of significant 
>>digits. The Taylor series for the trig functions might be a painfull.
> 
> 
> Taylor series usually are painful for anything you want to calculate
> by any practical means.  Slow convergence but, for a change, quickly
> growing roundup errors and things like that.  An importance and uses
> of Taylor series lie elsewhere.
> 
> OTOH polynomial approximations, or rational ones (after all division
> is quite quick on modern processors), can be fast and surprisingly
> precise; especially if you know bounds for your arguments and that
> that range is not too wide.  Of course when doing that in a fixed
> point one needs to pay attention to possible overflows and
> structuring calculations to guard against a loss of precision is
> always a good idea.
> 
> My guess is that finding some fixed-point libraries, at least to use
> as a starting point, should be not too hard.

See the "Handbook of Mathematical Functions" by Abromawitz and Stegun, 
Dover Publications (ISBN 486-61272-2, Library of Congress number 
65-12253) which has some small but accurate polynomial approximations 
for many functions.


-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

