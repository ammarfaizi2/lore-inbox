Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWHVRho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWHVRho (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 13:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWHVRho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 13:37:44 -0400
Received: from smtp13.orange.fr ([193.252.22.54]:48136 "EHLO
	smtp-msa-out13.orange.fr") by vger.kernel.org with ESMTP
	id S1751408AbWHVRhn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 13:37:43 -0400
X-ME-UUID: 20060822173742335.51F737000097@mwinf1301.orange.fr
Subject: Re: mplayer + heavy io: why ionice doesn't help?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Denis Vlasenko <vda.linux@googlemail.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Eric Piel <Eric.Piel@tremplin-utc.net>, mplayer-users@mplayerhq.hu,
       linux-kernel@vger.kernel.org
In-Reply-To: <200608221826.08802.vda.linux@googlemail.com>
References: <200608181937.25295.vda.linux@googlemail.com>
	 <200608201843.58849.vda.linux@googlemail.com>
	 <1156109768.10565.55.camel@mindpipe>
	 <200608221826.08802.vda.linux@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 22 Aug 2006 19:38:10 +0200
Message-Id: <1156268290.5069.2.camel@bip.parateam.prv>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 22 août 2006 à 18:26 +0200, Denis Vlasenko a écrit :

> > I think the problem is also due to mplayer's faulty design.  It should
> > be multithreaded and use RT threads for the time sensitive work, like
> > all professional AV applications and many other consumer players do.
> 
> RT - yes, multithreaded - unsure. Witness how squid manages to
> serve hundreds of simultaneous streams using just a single process.
> 
> Multithreading seems cool on the first glance and it is easier to code
> than clever O_NONBLOCK/select/poll/etc stuff. However,
> on single-CPU boxes, which are still a majority, multithreading
> just incurs context switching penalty. It cannot magically
> make CPU do more work in a unit of time.

The problem with mplayer is latency more than throughput, and for that
multithreading is king. Squid can get away with a 100ms delay between
two packets, mplayer can't.

	Xav

