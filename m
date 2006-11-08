Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965891AbWKHOvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965891AbWKHOvJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965893AbWKHOvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:51:08 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:42264 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965891AbWKHOvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:51:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fOYNXVGXLfzoLGi6wJh/wsFXtTsfzayR7UvCo6Rt/O4vhJLC1ocRhBbVZs0loUUODd2cPyOCPmbblPg/S1q+QJ4QFMI1dNZN7lbG99ODJDV+c3iJkRePKD4mUCr6fiYRWXpWKIUyEXP6Bt7iBt/C6jGULLF5V4JbQRvH+JpBevY=
Message-ID: <b6a2187b0611080651tf0313dfp706ec15b8b7776e7@mail.gmail.com>
Date: Wed, 8 Nov 2006 22:51:06 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH] Update MMCONFIG resource insertion to check against e820 map.
Cc: "Aaron Durbin" <adurbin@google.com>, linux-kernel@vger.kernel.org,
       "Matthew Wilcox" <matthew@wil.cx>, discuss@x86-64.org
In-Reply-To: <200611081254.31635.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8f95bb250611071249i6cf92b98p99d4b08275de6656@mail.gmail.com>
	 <200611081254.31635.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/06, Andi Kleen <ak@suse.de> wrote:
> On Tuesday 07 November 2006 21:49, Aaron Durbin wrote:
> > Check to see if MMCONFIG region is marked as reserved in the e820 map
> > before inserting the MMCONFIG region into the resource map. If the region
> > is not entirely marked as reserved in the e820 map attempt to find a region
> > that is. Only insert the MMCONFIG region into the resource map if there was
> > a region found marked as reserved in the e820 map.  This should fix a known
> > regression in 2.6.19 by not reserving all of the I/O space on misconfigured
> > systems.
>
> Jeff, did this fix your problem?

Yes, it did. I can only verify that x86 32-bit tg3 is working nicely now.

Thanks to all who helped!

Jeff.
