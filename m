Return-Path: <linux-kernel-owner+w=401wt.eu-S1161070AbXAELts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbXAELts (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 06:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbXAELts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 06:49:48 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:24947 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161070AbXAELtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 06:49:47 -0500
Message-ID: <459E3B56.3040907@tls.msk.ru>
Date: Fri, 05 Jan 2007 14:49:42 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: open(O_DIRECT) on a tmpfs?
References: <459CEA93.4000704@tls.msk.ru> <Pine.LNX.4.64.0701041242530.27899@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0701041242530.27899@blonde.wat.veritas.com>
X-Enigmail-Version: 0.94.1.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Thu, 4 Jan 2007, Michael Tokarev wrote:
>> I wonder why open() with O_DIRECT (for example) bit set is
>> disallowed on a tmpfs (again, for example) filesystem,
>> returning EINVAL.
[]
> p.s.  You said "O_DIRECT (for example)" - what other open
> flag do you think tmpfs should support which it does not?

Well.  Somehow I was under an impression O_SYNC behaves the
same as O_DIRECT on a tmpfs.  But I was wrong - tmpfs permits
O_SYNC opens just fine.  Strange thing to do having in mind
its behaviour with O_DIRECT - to me it's inconsistent ;)
But that's it - looks like only O_DIRECT is "mishandled"
(which is not a big deal obviously).

Thanks for your time!

/mjt
