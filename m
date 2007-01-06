Return-Path: <linux-kernel-owner+w=401wt.eu-S1751117AbXAFCaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbXAFCaF (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbXAFCaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:30:05 -0500
Received: from mail.macqel.be ([194.78.208.39]:15875 "EHLO mail.macqel.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120AbXAFC3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:29:43 -0500
Date: Sat, 6 Jan 2007 03:29:41 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: linux-kernel@vger.kernel.org
Subject: RTC subsystem and fractions of seconds
Message-ID: <20070106022941.GA32125@ingate.macqel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

A comment in driver/rtc/hctosys says :

    /* IMPORTANT: the RTC only stores whole seconds. It is arbitrary
     * whether it stores the most close value or the value with partial
     * seconds truncated. However, it is important that we use it to store
     * the truncated value. This is because otherwise it is necessary,
     * in an rtc sync function, to read both xtime.tv_sec and
     * xtime.tv_nsec. On some processors (i.e. ARM), an atomic read
     * of >32bits is not possible. So storing the most close value would
     * slow down the sync API. So here we have the truncated value and
     * the best guess is to add 0.5s.
     */

I work with ST m41t81 rtc's.  Those rtc's actually have a 1/100th of second
register.  Should the generic rtc interface not support that ? 

Philippe
-- 
