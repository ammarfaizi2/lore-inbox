Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265162AbTFYXDU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 19:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbTFYXDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 19:03:20 -0400
Received: from 82-43-130-207.cable.ubr03.mort.blueyonder.co.uk ([82.43.130.207]:9694
	"EHLO efix.biz") by vger.kernel.org with ESMTP id S265162AbTFYXDR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 19:03:17 -0400
Subject: Re: AMD MP, SMP, Tyan 2466
From: Edward Tandi <ed@efix.biz>
To: Timothy Miller <miller@techsource.com>
Cc: joe briggs <jbriggs@briggsmedia.com>,
       Artur Jasowicz <kernel@mousebusiness.com>,
       Brian Jackson <brian@brianandsara.net>,
       Bart SCHELSTRAETE <Bart.SCHELSTRAETE@dhl.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3EFA2939.2060005@techsource.com>
References: <BB1F47F5.17533%kernel@mousebusiness.com>
	 <200306251501.14207.jbriggs@briggsmedia.com>
	 <1056567378.31260.9.camel@wires.home.biz> <3EFA2939.2060005@techsource.com>
Content-Type: text/plain
Message-Id: <1056583075.31265.22.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 26 Jun 2003 00:17:56 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-25 at 23:59, Timothy Miller wrote:
> Edward Tandi wrote:
> > 
> > Yes, for SMP mode you absolutely need to use 'registered' RAM. Normal
> > PC2100 ram will work OK with one processor but quickly fails with two (I
> > had the same problems). Apparently, DDR RAM uses one clock edge to
> > transfer in one direction and the opposite edge to transfer back again
> > so the registers do synchronisation between one processor writing to the
> > same location that the other one reads from. That's how it was explained
> > to me anyway.
> > 
> DDR memory works very much like single data rate, except that data is 
> transferred (in whichever direction it's going) on both edges of the 
> clock, thus doubling the transfer rate.  The memory does not switch 
> between reading and writing as you describe it.
> 
> I believe registering is for reliability.  Data is transferred one clock 
> cycle later but reduces signal loading.

Thanks for the clarification. I do not profess to be an expert in the
technology. Two writes or a read+write per clock cycle is close enough
for the purpose of the discussion.

The point I was trying to make is that the registers are there to deal
with an SMP race condition of some sort. Athlon MP motherboards fitted
with two processors will not work properly without 'registered' RAM. I
have hard experience of this and it this experience I am sharing with
someone who is seeing the same symptoms.

Ed-T.


