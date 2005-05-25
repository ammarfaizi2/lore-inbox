Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVEYVld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVEYVld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 17:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVEYVld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 17:41:33 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:62101
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261180AbVEYVl2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 17:41:28 -0400
Subject: Re: 2.6.11 timeval_to_jiffies() wrong for ms resolution timers
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: george@mvista.com
Cc: "Davda, Bhavesh P (Bhavesh)" <bhavesh@avaya.com>,
       Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4294D9C6.3060501@mvista.com>
References: <21FFE0795C0F654FAD783094A9AE1DFC07AFE7C1@cof110avexu4.global.avaya.com>
	 <4294D9C6.3060501@mvista.com>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 25 May 2005 23:41:40 +0200
Message-Id: <1117057300.6736.324.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-25 at 13:02 -0700, George Anzinger wrote:
> We ARE trying to get this into the main line, but save the patch, there is no 
> way to get millisecond accuracy in the kernel OR in user land.  Never has been! 
>   That is why the patch exists.  There was an effort by some university folks 
> prior to the HRT stuff, but AFAIK it is not supported or uptodate.

It's up to date and supported, if you are talking about the KURT
project. Just the website is hopelessly out of date.

> As for jiffies vs time, my understanding from senior time folks is that 1/HZ as 
> a resolution is just an approximation.  We do the best we can but the x86 is 
> really the PITs (pun intended) when it comes to time keeping resources.  If you 
> really want millisecond accuracy, you may need to consider another platform....

Why so ? Accepted PIT, is a PITA due to the ISA access penalty, but it
still allows you to run timers below millisecond accuracy.

tglx




