Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVGOAPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVGOAPG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 20:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbVGOAPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 20:15:06 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:62663 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261789AbVGOAPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 20:15:03 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       torvalds@osdl.org, vojtech@suse.cz, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
In-Reply-To: <9a874849050714170465c979c3@mail.gmail.com>
References: <42D3E852.5060704@mvista.com> <42D540C2.9060201@tmr.com>
	 <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
	 <20050713184227.GB2072@ucw.cz>
	 <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
	 <1121282025.4435.70.camel@mindpipe>
	 <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <9a874849050714170465c979c3@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 20:15:05 -0400
Message-Id: <1121386505.4535.98.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-15 at 02:04 +0200, Jesper Juhl wrote:
> While reading this thread it occoured to me that perhaps what we
> really want (besides sub HZ timers) might be for the kernel to
> auto-tune HZ?
> 
> Would it make sense to introduce a new config option (say
> CONFIG_HZ_AUTO) that when selected does something like this at boot:
> 
> if (running_on_a_laptop()) {
>     set_HZ_to(250);
> }

I don't think this will fly because we take a big performance hit by
calculating HZ at runtime.

Lee

