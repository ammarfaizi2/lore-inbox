Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273745AbRIQWmd>; Mon, 17 Sep 2001 18:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273736AbRIQWlF>; Mon, 17 Sep 2001 18:41:05 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:9005 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273732AbRIQWku>; Mon, 17 Sep 2001 18:40:50 -0400
Subject: Re: [SMP lock BUG?] Re: Feedback on preemptible kernel patch
From: Robert Love <rml@tech9.net>
To: Pavel Machek <pavel@suse.cz>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Roger Larsson <roger.larsson@norran.net>, linux-kernel@vger.kernel.org,
        nigel@nrg.org
In-Reply-To: <20010914091558.A35@toy.ucw.cz>
In-Reply-To: <000901c138bbe151270/mnt/sendme10411ac@local>
	<1000007070.836.14.camel@phantasy>
	<001a01c1390262c7f30/mnt/sendme10411ac@local> 
	<20010914091558.A35@toy.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.17.07.08 (Preview Release)
Date: 17 Sep 2001 18:41:46 -0400
Message-Id: <1000766512.12771.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-09-14 at 05:15, Pavel Machek wrote:
> is it legal to kmap_atomic(a,b); kmap_atomic(c,d); kunmap_atomic(a,b); ?
> If so, your patch may need some ounting....

ctx_sw_on and ctx_sw_off use a recursive spinlock, so the calls to
kunmap_atomic won't drop the slock until the last call.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

