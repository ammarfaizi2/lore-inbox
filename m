Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWFBKNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWFBKNE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 06:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWFBKNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 06:13:04 -0400
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:56736 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751380AbWFBKNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 06:13:02 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 20:12:44 +1000
User-Agent: KMail/1.9.1
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       "'Chris Mason'" <mason@suse.com>, "Ingo Molnar" <mingo@elte.hu>
References: <000001c6862a$5d7142d0$114ce984@amr.corp.intel.com>
In-Reply-To: <000001c6862a$5d7142d0$114ce984@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606022012.44866.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 June 2006 19:53, Chen, Kenneth W wrote:
> Yeah, but that is the worst case though.  Average would probably be a lot
> lower than worst case.  Also, on smt it's not like the current logical cpu
> is getting blocked because of another task is running on its sibling CPU.
> The hardware still guarantees equal share of hardware resources for both
> logical CPUs.

"Equal share of hardware resources" is exactly the problem; they shouldn't 
have equal share since they're sharing one physical cpu's resources. It's a 
relative breakage of the imposed nice support and I disagree with your 
conclusion.

-- 
-ck
