Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbTDJWh5 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 18:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264215AbTDJWhz (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 18:37:55 -0400
Received: from air-2.osdl.org ([65.172.181.6]:24498 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264213AbTDJWhy (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 18:37:54 -0400
Date: Thu, 10 Apr 2003 15:49:02 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davidm@hpl.hp.com, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: proc_misc.c bug
Message-Id: <20030410154902.32f48f9c.rddunlap@osdl.org>
In-Reply-To: <1050011057.12930.134.camel@dhcp22.swansea.linux.org.uk>
References: <200304102202.h3AM2YH3021747@napali.hpl.hp.com>
	<1050011057.12930.134.camel@dhcp22.swansea.linux.org.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Apr 2003 22:44:17 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

| On Thu, 2003-04-10 at 23:02, David Mosberger wrote:
| > The workaround below is to allocate 4KB per 8 CPUs.  Not really a
| > solution, but the fundamental problem is that /proc/interrupts
| > shouldn't use a fixed buffer size in the first place.  I suppose
| > another solution would be to use vmalloc() instead.  It all feels like
| > bandaids though.
| 
| How about switching to Al's seqfile interface ?

It's already using it, but it uses the simple/single version of it,
which doesn't automagically extend the output buffer area when
it's full, so a max size buffer has to be allocated for it
up front.

I'll look at changing it unless somebody beats me (to it :).

--
~Randy   ['tangent' is not a verb...unless you believe that
          "in English any noun can be verbed."]
