Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265600AbUBFSQT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265578AbUBFSQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:16:19 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:21151 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265622AbUBFSQQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:16:16 -0500
Message-Id: <200402061813.i16IDO707026@owlet.beaverton.ibm.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, mjbligh@us.ibm.com,
       dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1 
In-reply-to: Your message of "Fri, 06 Feb 2004 20:38:25 +1100."
             <40236091.40807@cyberone.com.au> 
Date: Fri, 06 Feb 2004 10:13:24 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    >+	if ((long)*imbalance < 0)
    >+		*imbalance = 0;
    > 
    
    You're right Rick, thanks for catching this. Why do you have
    this last test though? This shouldn't be possible?

A combination of paranoia and leftover code from a previous fix :)  At the
least, this could probably become a BUG_ON now, or I wouldn't cry if
we took it out entirely.

Rick
