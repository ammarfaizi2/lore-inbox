Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbVH3P5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVH3P5k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 11:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbVH3P5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 11:57:39 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:9399 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751446AbVH3P5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 11:57:39 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: Dynamic tick for 2.6.14 - what's the plan?
Date: Tue, 30 Aug 2005 17:01:49 +0100
User-Agent: KMail/1.8.90
Cc: Con Kolivas <kernel@kolivas.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Christopher Friesen <cfriesen@nortel.com>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Thomas Renninger <trenn@suse.de>
References: <1125354385.4598.79.camel@mindpipe> <200508301348.59357.kernel@kolivas.org> <20050830123132.GH6055@atomide.com>
In-Reply-To: <20050830123132.GH6055@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508301701.49228.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 August 2005 13:31, Tony Lindgren wrote:
[snip]
> >
> > Same issue, it's waiting on dynticks before being reworked.
>
> Also one more minor issue; Dyntick can cause slow boots with dyntick
> enabled from boot because the there's not much in the timer queue
> until init.
>
> This probably does not show up much on x86 though because of the
> short hardware timers.

You could disable it until jiffies >= 0; this covers the boot criteria and 
still allows for moderate savings post boot (though maybe on embedded systems 
the delay is too long?).

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
