Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265610AbUBFWxy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 17:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266864AbUBFWwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 17:52:02 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:3994 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265610AbUBFWvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 17:51:53 -0500
Message-Id: <200402062249.i16Mn0013884@owlet.beaverton.ibm.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, mjbligh@us.ibm.com,
       dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1 
In-reply-to: Your message of "Sat, 07 Feb 2004 09:40:26 +1100."
             <402417DA.4070308@cyberone.com.au> 
Date: Fri, 06 Feb 2004 14:49:00 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    No you definitely still need the test... this is what I mean:
    
           if (avg_load > this_load)
                    *imbalance = min(max_load - avg_load, avg_load - this_load);
            else
                    *imbalance = 0;

Ah, yes, ok. I thought you were saying it would be zero because of code
elsewhere.  Yup, that'll work.

Rick
