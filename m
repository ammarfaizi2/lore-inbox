Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267517AbUHDXiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbUHDXiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 19:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267515AbUHDXiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 19:38:07 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:21109 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S267516AbUHDXhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 19:37:16 -0400
Date: Wed, 4 Aug 2004 16:33:57 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: dipankar@in.ibm.com, shemminger@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Updated RCU documentation improvement
Message-ID: <20040804233357.GE1239@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040804141608.GA1865@us.ibm.com> <1091657826.2964.3.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091657826.2964.3.camel@laptop.cunninghams>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 08:17:07AM +1000, Nigel Cunningham wrote:
> Hi.
> 
> What does RCU stand for? I haven't looked very hard, but all I've seen
> is RCU, and not an expansion of the abbreviation.
> 
> Regards,

Hello, Nigel,

RCU stands for "read-copy update".  The rationale behind the name
is that readers proceed concurrently with updaters, and updaters
must make copies in order for complex updates to appear atomic
to readers.

That said, most uses of RCU simply add and delete items.  Very
few uses do in-place RCU-protected updates.

						Thanx, Paul
