Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271590AbTGQWQY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271583AbTGQWON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:14:13 -0400
Received: from pirx.hexapodia.org ([208.42.114.113]:12652 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S271557AbTGQWN3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:13:29 -0400
Date: Thu, 17 Jul 2003 17:28:23 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: typecast bug in sched.c bites reschedule_idle on alpha
Message-ID: <20030717172823.C1739@hexapodia.org>
References: <20030717165139.B12164@hexapodia.org> <20030718022043.A5793@pls.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030718022043.A5793@pls.park.msu.ru>; from ink@jurassic.park.msu.ru on Fri, Jul 18, 2003 at 02:20:43AM +0400
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 02:20:43AM +0400, Ivan Kokshaysky wrote:
> On Thu, Jul 17, 2003 at 04:51:39PM -0500, Andy Isaacson wrote:
> > Since asm-alpha/timex.h defines cycles_t as unsigned int, this
> > comparison is always false.  Changing it to (cycles_t)-1 fixes the
> > problem.
> 
> Nice catch, Andy. Thanks.

Wasn't me, it was Bruce Keller (but I don't know if he wants his email
address plastered all over linux-kernel).  I just cleaned up and
prepared a patch with bug description.

-andy
