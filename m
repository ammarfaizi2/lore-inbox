Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbVIMObX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVIMObX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbVIMObX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:31:23 -0400
Received: from dvhart.com ([64.146.134.43]:15746 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932648AbVIMObW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:31:22 -0400
Date: Tue, 13 Sep 2005 07:31:24 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Sonny Rao <sonny@burdell.org>, Danny ter Haar <dth@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm3
Message-ID: <268810000.1126621883@[10.10.2.4]>
In-Reply-To: <20050913070204.GA30231@kevlar.burdell.org>
References: <20050912024350.60e89eb1.akpm@osdl.org> <20050912200914.GA13962@kevlar.burdell.org> <dg4qeg$27m$1@news.cistron.nl> <20050912220617.GA18215@kevlar.burdell.org> <dg5n7q$daf$1@news.cistron.nl> <20050913070204.GA30231@kevlar.burdell.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Sonny Rao <sonny@burdell.org> wrote (on Tuesday, September 13, 2005 03:02:04 -0400):

> On Tue, Sep 13, 2005 at 05:14:34AM +0000, Danny ter Haar wrote:
>> Sonny Rao  <sonny@burdell.org> wrote:
>> > Are you using jumbo frames or anything like that?
>> 
>> Not as far as i know.
>> 
>> I gave the kernel some more buffer as stated on
>> http://home.cern.ch/~jes/gige/acenic.html
>> 
>> echo 256144 > /proc/sys/net/core/rmem_max
>> echo 262144 > /proc/sys/net/core/wmem_max
> 
> Not sure if this could lead to higher order allocations -- the only
> place I think it might happen is in sock_kmalloc() 
> 
> Dunno, Martin?

Not sure. Throw a dump_stack in __alloc_pages conditional on if order > 0.
If it spews too much output, ratelimit it by incrementing a static variable
each time, and only printing if mod 100 or 1000 or something, but I suspect
it'll be OK at full rate.

M.

