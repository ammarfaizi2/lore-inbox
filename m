Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVFHOY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVFHOY1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 10:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVFHOY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 10:24:26 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:43787 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S261254AbVFHOXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 10:23:30 -0400
Message-ID: <42A6FF41.5040109@shadowen.org>
Date: Wed, 08 Jun 2005 15:22:57 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Andrey Panin <pazke@donpac.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1
References: <20050607042931.23f8f8e0.akpm@osdl.org>
In-Reply-To: <20050607042931.23f8f8e0.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've been seeing an early boot hang on IBM x-series (at least on an
x440) with -rc6-mm1.  Finally got hold of a box to go search for this
and it seems that backing out the three patches below fixes it.

 515  dmi-move-acpi-boot-quirk.patch
 516  dmi-move-acpi-sleep-quirk.patch
 517  dmi-remove-central-blacklist.patch

I am pretty sure it is actually the first one (thats where my bisection
search pointed) but I had to drop the other two to back it out.  Anyhow,
2.6.12-rc6-mm1 boots on an x440 with these backed out.

Cheers.

-apw
