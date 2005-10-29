Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbVJ2AF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbVJ2AF2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 20:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbVJ2AF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 20:05:28 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:2978 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750871AbVJ2AF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 20:05:27 -0400
Subject: Re: kernel-2.6.14-rc5-rt7 - 604.62 BogoMIPS (2.6.14-rc5 - 6024.43
	BogoMIPS) problem with bogometer ?
From: Steven Rostedt <rostedt@goodmis.org>
To: art@usfltd.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <200510281828.AA38666812@usfltd.com>
References: <200510281828.AA38666812@usfltd.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 28 Oct 2005 20:05:13 -0400
Message-Id: <1130544313.6169.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-28 at 18:28 -0500, art wrote:
> kernel-2.6.14-rc5-rt7 - 604.62 BogoMIPS (2.6.14-rc5 - 6024.43 BogoMIPS) problem with bogometer ?
> 
> kernel-2.6.14-rc5-rt7 -- Calibrating delay using timer specific routine.. 604.62 BogoMIPS (lpj=302311)
> 
> kernel-2.6.14-rc5 -- Calibrating delay using timer specific routine.. 6024.43 BogoMIPS (lpj=12048877)

Already been fixed and will be out in Ingo's next release.  Before
high-res was activated, the ktimers was causing jiffies to go up faster
than HZ and this caused bad calculations of BogoMIPS.  So for now just
sit back and relax, it doesn't harm anything right now. :)

-- Steve

