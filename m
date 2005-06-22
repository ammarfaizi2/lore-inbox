Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVFVUNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVFVUNH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 16:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVFVUNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 16:13:00 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:34571 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S262002AbVFVUI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 16:08:59 -0400
Date: Wed, 22 Jun 2005 13:15:36 -0700
To: Karim Yaghmour <karim@opersys.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, andrea@suse.de,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050622201536.GA14052@nietzsche.lynx.com>
References: <1119287612.6863.1.camel@localhost> <20050620183115.GA27028@nietzsche.lynx.com> <42B98B20.7020304@opersys.com> <20050622192927.GA13817@nietzsche.lynx.com> <42B9C5D1.3020403@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B9C5D1.3020403@opersys.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 04:10:57PM -0400, Karim Yaghmour wrote:
> Bill Huey (hui) wrote:
> > FreeBSD went through some slow down when they moved to SMPng, but not
> > the kind of numbers you show for things surrounding the network stack.
> > Something clearly bad happened.
> 
> Note that the numbers are not freak accidents, they are consistent
> accross the various setups. So in total, that's 15 LMbench runs,
> all showing consistent _severe_ cost for preempt_rt. And this despite

Yeah, I looked at the numbers more carefully and it's clearly showing
some problems. There is a significant context switch penalty with
irq-threads and I wouldn't surprise if this is what's going on.

bill

