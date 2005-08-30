Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbVH3K65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbVH3K65 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 06:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVH3K65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 06:58:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20908 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751339AbVH3K65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 06:58:57 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1125055250.5365.33.camel@localhost.localdomain>
References: <1123011928.1590.43.camel@localhost.localdomain>
	 <1123025895.25712.7.camel@dhcp153.mvista.com>
	 <1123027226.1590.59.camel@localhost.localdomain>
	 <1123035909.11101.1.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1123036936.1590.69.camel@localhost.localdomain>
	 <1123037933.11101.11.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1123080606.1590.119.camel@localhost.localdomain>
	 <1123087447.1590.136.camel@localhost.localdomain>
	 <20050812125844.GA13357@elte.hu>
	 <1125030249.5365.23.camel@localhost.localdomain>
	 <20050826060815.GB17783@elte.hu>
	 <1125055250.5365.33.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1125399509.1910.6.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 30 Aug 2005 11:58:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2005-08-26 at 12:20, Steven Rostedt wrote:

> > could you try a), how clean does it get? Personally i'm much more in 
> > favor of cleanliness. On the vanilla kernel a spinlock is zero bytes on 
> > UP [the most RAM-sensitive platform], and it's a word on typical SMP.

It's a word, maybe; but it's a word used only by ext3 afaik, and it's
getting added to the core buffer_head.  Not very nice.  It certainly
looks like the easiest short-term way out for a development patch
series, though.

--Stephen

