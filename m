Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUIOJK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUIOJK3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 05:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUIOJK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 05:10:29 -0400
Received: from mproxy.gmail.com ([216.239.56.249]:40091 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264261AbUIOJHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 05:07:46 -0400
Message-ID: <c0a09e5c040915020768509041@mail.gmail.com>
Date: Wed, 15 Sep 2004 02:07:45 -0700
From: Andrew Grover <andy.grover@gmail.com>
Reply-To: Andrew Grover <andy.grover@gmail.com>
To: Tim Hockin <thockin@hockin.org>
Subject: Re: [patch] kernel sysfs events layer
Cc: Greg KH <greg@kroah.com>, Robert Love <rml@ximian.com>,
       Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040915044830.GA4919@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040910235409.GA32424@kroah.com>
	 <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org>
	 <20040915000753.GA24125@kroah.com> <20040915010901.GA19524@vrfy.org>
	 <20040915011146.GA27782@hockin.org>
	 <1095214229.20763.6.camel@localhost> <20040915031706.GA909@hockin.org>
	 <20040915034229.GA30747@kroah.com> <20040915044830.GA4919@hockin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 21:48:30 -0700, Tim Hockin <thockin@hockin.org> wrote:
> ACPI *has* it's own event system.  It's fine, but it's Yet Another Event
> System.  I'd love to see it use this.  It has mostly the same behaviors,
> except it has a data payload (a string and couple unsigned ints, if I
> recall).  If this API can't handle that, then we have to keep ACPI's
> current event system.  Wouldn't it be nicer to remove code and encourage
> migrating towards standard(ish) APIs?
> 
> Again, other than payload, why NOT use this API for ACPI?

IIRC the two possible future destinations for ACPI events are this,
and the input layer. There are some ACPI events that clearly should go
through this mechanism (e.g. thermal), some the input layer (e.g.
weird laptop extra keys), and maybe some in between? I know David
Bronaugh was looking into this a few weeks ago, maybe he'll pop back
up.

My 2c -- Andy
