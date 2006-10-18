Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422768AbWJRSbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422768AbWJRSbV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422769AbWJRSbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:31:21 -0400
Received: from gw.goop.org ([64.81.55.164]:14286 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1422768AbWJRSbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:31:20 -0400
Message-ID: <45367350.4070902@goop.org>
Date: Wed, 18 Oct 2006 11:32:48 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix generic WARN_ON message
References: <4535902E.1000608@goop.org> <20061018055542.GA14784@elte.hu>
In-Reply-To: <20061018055542.GA14784@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> Firstly, most WARN_ON()s are /bugs/, not warnings ... If it's a real 
> warning, a KERN_INFO printk should be done.
>   

It seems to me that either the warnings are really bugs, in which case 
they should be using BUG/BUG_ON, or they're not really bugs, in which 
case they should be presented differently.

> Secondly, the reason i changed it to the 'BUG: ...' format is that i 
> tried to make it easier for automated tools (and for users) to figure 
> out that a kernel bug happened.
>   

Well, are they bugs or not?  I think people are more confused by the 
"BUG" prefix and stacktrace than helped by it (even an experienced eye 
will glance-parse a BUG+stack trace as a serious oops-level problem 
rather than a warning).

    J

    J
