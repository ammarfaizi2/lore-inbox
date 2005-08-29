Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbVH2SND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVH2SND (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 14:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbVH2SND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 14:13:03 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11664 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751261AbVH2SNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 14:13:01 -0400
Subject: Re: 2.6.13 new option timer frequency
From: Lee Revell <rlrevell@joe-job.com>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200508291857.15746.nick@linicks.net>
References: <200508291857.15746.nick@linicks.net>
Content-Type: text/plain
Date: Mon, 29 Aug 2005 14:12:56 -0400
Message-Id: <1125339176.4598.51.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-29 at 18:57 +0100, Nick Warne wrote:
> Hi all,
> 
> I built and installed 2.6.13 today, and oldconfig revealed the new option for 
> timer frequency.
> 
> I searched the LKML on this, but all I found is the technical stuff - not 
> really any layman solutions.
> 
> Two n00b questions here:
> 
> What does this do/what is it for?
> 

Selects the frequency of the timer interrupt.  This controls the timing
resolution of system calls.  So previously poll/select could be used
with a 1ms timeout.  Now with the default settings it can only do 4ms. 

> I selected default, 250Hz.  If this is now an option, what was it before?

The previous value was 1000HZ.  And yes, changing the default from 1000
to 250 breaks the expected "make oldconfig" behavior.  Lots of people
are not happy about it, but were overruled by Linus.

Lee

