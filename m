Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVC2VC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVC2VC1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 16:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVC2VC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 16:02:27 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:34536 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261420AbVC2VCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 16:02:23 -0500
Subject: Re: [RFD] 'nice' attribute for executable files
From: Lee Revell <rlrevell@joe-job.com>
To: Wiktor <victorjan@poczta.onet.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4249B2B8.1090807@poczta.onet.pl>
References: <4249B2B8.1090807@poczta.onet.pl>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 16:02:22 -0500
Message-Id: <1112130142.5141.23.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 21:55 +0200, Wiktor wrote:
> Hi all,
> 
> recently i had to run some program (xmms) with lowered nice value as 
> normal user. to do that i had to su to the root account and then execute 
> nice --5 xmms.

Let me guess, the sound skips unless you run at a low nice value.
That's bad design on the part of XMMS.

nice is the wrong way to handle RT constraints.  You need a proper
design (ie multithreaded).

See JACK for an example of how to do it right.

http://jackit.sf.net

Or, since you don't need low latency, use a bigger buffer.

Proper handling of RT constraints has been discussed to death on LKML
and other lists (executive summary: almost no one does it right.
mplayer is one of the most egregious offenders).

Lee

