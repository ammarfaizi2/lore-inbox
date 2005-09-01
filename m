Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbVIAPHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbVIAPHY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbVIAPHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:07:24 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52207 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1030186AbVIAPHW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:07:22 -0400
Subject: Re: PREEMPT_RT with e1000
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org
In-Reply-To: <1125585819.32005.2.camel@c-67-188-6-232.hsd1.ca.comcast.net>
References: <1125518602.15034.3.camel@dhcp153.mvista.com>
	 <20050901071008.GD5179@elte.hu>
	 <1125585819.32005.2.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Thu, 01 Sep 2005 08:07:07 -0700
Message-Id: <1125587227.32005.8.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-01 at 07:43 -0700, Daniel Walker wrote:
> On Thu, 2005-09-01 at 09:10 +0200, Ingo Molnar wrote:
> > * Daniel Walker <dwalker@mvista.com> wrote:
> > 
> > > It looks like Gigabit Ethernet is still having some problems. This is 
> > > with the e1000 driver. If I remove all the qdisc_restart changes it 
> > > starts to work the warning below goes away, but it has 
> > > smp_processor_id warnings.
> > 
> > btw., what does "problems" mean, precisely - does it not work at all, or 
> > does it produce the lockup under certain loads?
> 
> It hangs when I un'tar a big archive over NFS, but otherwise it works
> slowly . The "possible softlockup" must mean it's doing some major
> looping in/around qdisc_restart() . 

Another note, the possible softlockup warning is disconnected from the
actual lockup . I get several possible softlockup warnings then nothing,
then a hang with no warning. 

Daniel

