Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264331AbUD0UUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264331AbUD0UUU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 16:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264334AbUD0UUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 16:20:20 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:33672 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S264331AbUD0UUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 16:20:16 -0400
Date: Wed, 28 Apr 2004 00:20:18 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: Dru <andru@treshna.com>, linux-xfs@oss.sgi.com,
       =?koi8-r?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: status of Linux on Alpha?
Message-ID: <20040428002018.A827@den.park.msu.ru>
References: <yw1xr7vcn1z2.fsf@ford.guide> <20040329205233.5b7905aa@vaio.gigerstyle.ch> <20040404121032.7bb42b35@vaio.gigerstyle.ch> <20040409134534.67805dfd@vaio.gigerstyle.ch> <20040409134828.0e2984e5@vaio.gigerstyle.ch> <20040409230651.A727@den.park.msu.ru> <20040413194907.7ce8ceb7@vaio.gigerstyle.ch> <20040427185124.134073cd@vaio.gigerstyle.ch> <20040427215514.A651@den.park.msu.ru> <20040427200830.3f485a54@vaio.gigerstyle.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040427200830.3f485a54@vaio.gigerstyle.ch>; from gigerstyle@gmx.ch on Tue, Apr 27, 2004 at 08:08:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 08:08:30PM +0200, Marc Giger wrote:
> I wonder why it happens only with the XFS code. What I saw
> rw_sem is used all over the place in the kernel.

Dru says it happens with ext3 as well. XFS folks used their own
locking code (which hasn't suffered from that bug) until 2.6.4,
that's why you noticed the difference...
In either case, you need _really_ heavy write IO activity to
trigger the bug.

Ivan.
