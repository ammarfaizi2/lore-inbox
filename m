Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267301AbUIOS7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267301AbUIOS7n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 14:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUIOS7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 14:59:43 -0400
Received: from peabody.ximian.com ([130.57.169.10]:19138 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267301AbUIOS7b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 14:59:31 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@novell.com>
To: Andrew Grover <andy.grover@gmail.com>
Cc: Tim Hockin <thockin@hockin.org>, Greg KH <greg@kroah.com>,
       Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <c0a09e5c040915020768509041@mail.gmail.com>
References: <20040910235409.GA32424@kroah.com>
	 <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org>
	 <20040915000753.GA24125@kroah.com> <20040915010901.GA19524@vrfy.org>
	 <20040915011146.GA27782@hockin.org> <1095214229.20763.6.camel@localhost>
	 <20040915031706.GA909@hockin.org> <20040915034229.GA30747@kroah.com>
	 <20040915044830.GA4919@hockin.org>
	 <c0a09e5c040915020768509041@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 15 Sep 2004 14:58:27 -0400
Message-Id: <1095274707.23385.97.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 02:07 -0700, Andrew Grover wrote:

> IIRC the two possible future destinations for ACPI events are this,
> and the input layer. There are some ACPI events that clearly should go
> through this mechanism (e.g. thermal), some the input layer (e.g.
> weird laptop extra keys), and maybe some in between? I know David
> Bronaugh was looking into this a few weeks ago, maybe he'll pop back
> up.

Hey, Andy.

I'd like, if possible, to have ACPI use kevents.  ACPI makes sense as a
user.

The first question is whether or not ACPI could use the current kevent
model.  The current reactionary response is that kevent is too limited,
but that misses the point a bit.  The point is that you create kobjects
and better integrate with sysfs, and then kevent becomes trivial.

So if ACPI better took advantage of sysfs, would kevents be sufficient?

	Robert Love


