Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271329AbTHMCIP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 22:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271331AbTHMCIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 22:08:15 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:27399 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S271329AbTHMCIO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 22:08:14 -0400
Date: Tue, 12 Aug 2003 19:08:08 -0700
From: jw schultz <jw@pegasys.ws>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O13int for interactivity
Message-ID: <20030813020808.GC23237@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200308050207.18096.kernel@kolivas.org> <200308120629.31476.rob@landley.net> <3F38CAC6.7010808@cyberone.com.au> <200308120735.04035.rob@landley.net> <3F38D64C.2030109@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F38D64C.2030109@cyberone.com.au>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Reading this message may result in the loss of plausible deniability. Consult a lawyer to determine the extent of your liability
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 09:58:04PM +1000, Nick Piggin wrote:
> I have been hearing of people complaining the scheduler is worse than
> 2.4 so its not entirely obvious to me. But yeah lots of it is trial and
> error, so I'm not saying Con is wasting his time.

I've been watching Con and Ingo's efforts with the process
scheduler and i haven't seen people complaining that the
process scheduler is worse.  They have complained that
interactive processes seem to have more latency.  Con has
rightly questioned whether that might be because the process
scheduler has less control over CPU time allocation than in
2.4.  Remember that the process scheduler only manages the
CPU time not spent in I/O and other overhead.

If there is something in BIO chewing cycles it will wreak
havoc with latency no matter what you do about process
scheduling.  The work on BIO to improve bandwidth and reduce
latency was Herculean but the growing performance gap
between CPU and I/O is a formidable challenge.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
