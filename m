Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVGKU2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVGKU2P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 16:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbVGKU1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 16:27:33 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:17860 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262600AbVGKUZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:25:34 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Diego Calleja <diegocg@gmail.com>, azarah@nosferatu.za.org, akpm@osdl.org,
       cw@f00f.org, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       christoph@lameter.org
In-Reply-To: <176640000.1121107087@flay>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050708214908.GA31225@taniwha.stupidest.org>
	 <20050708145953.0b2d8030.akpm@osdl.org>
	 <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe>
	 <20050709203920.394e970d.diegocg@gmail.com>
	 <1120934466.6488.77.camel@mindpipe>  <176640000.1121107087@flay>
Content-Type: text/plain
Date: Mon, 11 Jul 2005 16:25:32 -0400
Message-Id: <1121113532.2383.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 11:38 -0700, Martin J. Bligh wrote:
> That's a very subjective viewpoint. Realize that this is a balancing
> act between latency and overhead ... and you're firmly only looking
> at one side of the argument, instead of taking a comprimise in the
> middle ...
> 
> If I start arguing for 100HZ on the grounds that it's much more efficient,
> will that make 250/300 look much better to you? ;-)

Mostly my argument is that all technical arguments aside, it's crazy to
change this in the middle of a stable kernel series.

My other objection is that 90% of the arguments for HZ=250 are based on
battery life.  But most Linux systems still don't run on batteries, so I
object to having to take a performance hit (a latency hit, which is the
same as performance for multimedia apps) for their sake.

Tickless + sub HZ timers is a win for everyone, the multimedia people
get better latency, and the laptop people get to run longer.

I guess CONFIG_HZ makes sense if the tickless solutions are not going to
be ready anytime soon.  But I don't see the problem with leaving the
default at 1000HZ and letting the laptop users lower it.

Lee

