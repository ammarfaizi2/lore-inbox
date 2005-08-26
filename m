Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965173AbVHZXiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbVHZXiD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 19:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbVHZXiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 19:38:03 -0400
Received: from peabody.ximian.com ([130.57.169.10]:60862 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S965173AbVHZXiB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 19:38:01 -0400
Subject: Re: [patch] IBM HDAPS accelerometer driver, with probing.
From: Robert Love <rml@novell.com>
To: dtor_core@ameritech.net
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <d120d50005082615445557d776@mail.gmail.com>
References: <1125094725.18155.120.camel@betsy>
	 <d120d50005082615445557d776@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 19:37:59 -0400
Message-Id: <1125099479.32272.29.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 17:44 -0500, Dmitry Torokhov wrote:

> Is this function used in a hot path to warrant using "unlikely"? There
> are to many "unlikely" in the code for my taste.

unlikely() can result in better, smaller, faster code.  and it acts as a
nice directive to programmers reading the code.

> input_[un]register_device and del_timer_sync are "long" operations. I
> think a semaphore would be better here.

I was considering moving all locking to a single semaphore, actually.

	Robert Love


