Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbTETFk1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 01:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTETFk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 01:40:27 -0400
Received: from franka.aracnet.com ([216.99.193.44]:28305 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263340AbTETFkZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 01:40:25 -0400
Date: Mon, 19 May 2003 22:53:11 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>
cc: "David S. Miller" <davem@redhat.com>, Arjan van de Ven <arjanv@redhat.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Gerrit Huizenga <gh@us.ibm.com>,
       John Stultz <johnstul@us.ibm.com>,
       James Cleverdon <jamesclv@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       Keith Mannthey <mannthey@us.ibm.com>
Subject: Re: userspace irq balancer
Message-ID: <88560000.1053409990@[10.10.2.4]>
In-Reply-To: <1053407030.13207.253.camel@nighthawk>
References: <200305191314.06216.pbadari@us.ibm.com> <1053382055.5959.346.camel@nighthawk> <20030519221111.P7061@devserv.devel.redhat.com> <1053382943.4827.358.camel@nighthawk> <1053401130.6830.3.camel@rth.ninka.net> <20030520034622.GK8978@holomorphy.com> <1053407030.13207.253.camel@nighthawk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Dave Hansen <haveblue@us.ibm.com> wrote (on Monday, May 19, 2003 22:03:50 -0700):

> On Mon, 2003-05-19 at 20:46, William Lee Irwin III wrote:
>> On Mon, May 19, 2003 at 08:25:31PM -0700, David S. Miller wrote:
>> > The in-kernel stuff MUST go.  It went in because "some benchmark went
>> > faster", but with no "why" describing why it might have improved
>> > performance.  We KNOW it absolutely sucks for routing and firewall
>> > applications.  The in-kernel bits were all a shamans dance, with zero
>> > technical "here is why this makes things go faster" description
>> > attached.  If I remember properly, the changelog message when the
>> > in-kernel irq balancing went in was of the form "this makes some
>> > specweb run go faster".
>> 
>> Absolutely. Not to mention the code for the in-kernel algorithm has
>> historically broken i386 ports using certain modes of Intel's
>> interrupt controllers.
> 
> OK, I just went and actually looked at the code again.  After
> suppressing my gag reflex, I started to remember all of the problems
> we've had with it, including fixing it for Intel's own clustered APIC
> mode. 
> 
> Does anyone have a patch to tear it out already?  Is the current proc
> interface acceptable, or do we want a syscall interface like wli
> suggests?

I have no frigging idea why you'd want to tear something out that works 
well already, and has a shitload of work put into it. 

Make it a config option if you don't like it, Keith has a patch to do 
that already - it's trivial. That way everyone can have what they want.

M.

