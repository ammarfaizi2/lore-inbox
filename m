Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbUJWWGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUJWWGZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 18:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbUJWWGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 18:06:24 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:25175 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261317AbUJWWGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 18:06:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=a1JB+WpvSahhNSgQ2f35RaIxqgUkbjRteotRGfxckup97B5Z2Q4uYI6Ohc9pSo0DLOr/PxBeyTQNbBNy+Jd6y+TAlBo0BM2gG14nzAWXRUnp15woqkPExROCXxP3AF294xAgeryLc4O2QZblhYRAxvmseJAV1wTT6kAfeUDevds=
Message-ID: <35fb2e5904102315066c6892aa@mail.gmail.com>
Date: Sat, 23 Oct 2004 23:06:03 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: paulmck@us.ibm.com
Subject: Re: [RFC][PATCH] Restricted hard realtime
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, karim@opersys.com
In-Reply-To: <20041023212421.GF1267@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041023194721.GB1268@us.ibm.com>
	 <1098562921.3306.182.camel@thomas> <20041023212421.GF1267@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004 14:24:21 -0700, Paul E. McKenney <paulmck@us.ibm.com> wrote:

> On Sat, Oct 23, 2004 at 10:22:01PM +0200, Thomas Gleixner wrote:

> > On Sat, 2004-10-23 at 12:47 -0700, Paul E. McKenney wrote:

> > I haven't seen an embedded SMP system yet. Focussing this on SMP systems
> > is ignoring the majority of possible applications.

> Seeing SMP support for ARM lead me to believe that this was not too far
> over the edge.

They have an SMP reference implementation, however many folks don't
actually want to go the dual core approach right now for embedded
designs (apparently the increased design complexity isn't worth it).
I've had protracted discussions about this very issue quite recently
indeed. Others will disagree, I'm only basing my statement upon
conversations with various engineers - I think your idea eventually
becomes interesting, but now is not the right moment to be pushing it
yet. People still don't want this now.

Talk to smartphone manufacturers who currently have dual ARM core
designs, one running Linux and the other running an RTOS for the GSM
and phone stuff, and they'll say they actually want to reduce the
design complexity down to a single core. Talking to people suggests
that multicore designs are good in certain situations (such as in the
case above), but in general people aren't yet going to respond to your
way of doing realtime :-) Yes you do have only one OS in there, maybe
that would change opinion, but we're not quite at the point where
everything is multicore so you're not going to convince the masses.

Having said all that, for a different perspective, I hack on ppc
(Xilinx Virtex II Pro) kernel and userspace stuff for some folks that
make high resolution imaging equipment, involving extremely precise
control over a pulsed signal and data acquisition (we're talking
nanosecond/microsecond precision). Since Linux obviously isn't capable
of this level of deterministic response right now we end up farming
out work to a separate core - it's unlikely your approach would
convince the hardware folks, but I guess it might be tempting at some
point in the future. Who knows.

Jon.
