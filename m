Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265271AbTLaUTa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 15:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265273AbTLaUTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 15:19:30 -0500
Received: from imf25aec.mail.bellsouth.net ([205.152.59.73]:2545 "EHLO
	imf25aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S265271AbTLaUT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 15:19:28 -0500
Subject: Re: udev and devfs - The final word
From: Rob Love <rml@ximian.com>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
In-Reply-To: <20031231192306.GG25389@kroah.com>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <E1AbWgJ-0000aT-00@neptune.local>
	 <20031231192306.GG25389@kroah.com>
Content-Type: text/plain
Message-Id: <1072901961.11003.14.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Wed, 31 Dec 2003 15:19:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-31 at 14:23, Greg KH wrote:

> What benefit would there be in "random" numbers? More compressed number
> space by giving out numbers sequentially?

That is one advantage.

> Or less having to work with the numbers because they become just
> cookies and never need to be inspected except in very small parts of
> the kernel?

Yup, especially this one.  It is not so much "let's make the device
numbers random" but "let's just not care what they are."

We can get to the point where we don't even need the explicit concept of
device numbers, but just "any old unique value" to use as a cookie.  The
kernel can pull that number from anywhere, and notify user-space via
udev ala hotplug.

	Rob Love


