Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVGFUTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVGFUTo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVGFUNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:13:07 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:49032 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262362AbVGFTrZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 15:47:25 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Wed, 6 Jul 2005 20:47:26 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050706183836.GA31269@elte.hu> <20050706184121.GA31399@elte.hu>
In-Reply-To: <20050706184121.GA31399@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507062047.26855.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 Jul 2005 19:41, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> > does the patch below help? We initialized the timestamps to 0, but
> > with jiffies starting out negative, that means a ~5 minutes gap until
> > we first reach a value of 0. That would explain the messages. The only
> > thing it doesnt explain, why did this only trigger on your box?
>
> here's an updated patch - it will print out all timestamps too. (you'll
> have to revert all previous softlockup patches first, via patch -R.)
>
> 	Ingo
>

Yep, thanks, that fixed it. I don't know why it only shows up on my 
configuration, but it was a bug, and this patch fixes it. I also took the 
liberty of upgrading to -06 while I was doing it, so I think you can probably 
release -07 with the specified changes.

So far no lockups, either, but I'm not convinced they're gone forever. I'll 
let you know how it goes.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
