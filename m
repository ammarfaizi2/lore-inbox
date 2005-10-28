Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVJ1XmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVJ1XmS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 19:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVJ1XmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 19:42:18 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:38542 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750775AbVJ1XmR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 19:42:17 -0400
Subject: Re: kernel-2.6.14-rc5-rt7 - 604.62 BogoMIPS (2.6.14-rc5 - 6024.43
	BogoMIPS) problem with bogometer ?
From: john stultz <johnstul@us.ibm.com>
To: art@usfltd.com
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <200510281828.AA38666812@usfltd.com>
References: <200510281828.AA38666812@usfltd.com>
Content-Type: text/plain
Date: Fri, 28 Oct 2005 16:42:15 -0700
Message-Id: <1130542935.27168.431.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-28 at 18:28 -0500, art wrote:
> kernel-2.6.14-rc5-rt7 - 604.62 BogoMIPS (2.6.14-rc5 - 6024.43 BogoMIPS) problem with bogometer ?
> 
> kernel-2.6.14-rc5-rt7 -- Calibrating delay using timer specific routine.. 604.62 BogoMIPS (lpj=302311)
> 
> kernel-2.6.14-rc5 -- Calibrating delay using timer specific routine.. 6024.43 BogoMIPS (lpj=12048877)

Assuming this is an i386 kernel, in the timeofday patches, the __delay
function has been converted to be a simple loop based delay instead of
TSC based, since the TSC has too many potential problems. 

That should explain a differing lpj value, although 10x smaller is a
little strange, so I'll dig into this on my system and see if I find
anything.

Do let me know if you see any actual changes in behavior (drivers acting
funny, etc).

thanks
-john



