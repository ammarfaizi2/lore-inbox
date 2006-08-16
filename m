Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWHPXIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWHPXIe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 19:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWHPXIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 19:08:34 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:49604 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751162AbWHPXId
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 19:08:33 -0400
Subject: Re: [NTP 0/9] NTP patches
From: john stultz <johnstul@us.ibm.com>
To: zippel@linux-m68k.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060810000146.913645000@linux-m68k.org>
References: <20060810000146.913645000@linux-m68k.org>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 16:07:27 -0700
Message-Id: <1155769647.6785.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 02:01 +0200, zippel@linux-m68k.org wrote:
> Here is my current version of the NTP patches.
> They precalculate as much possible and get rid of a lot of rather crude
> compensation code. The tick length is now a much simpler value, updated
> once a second, which greatly reduces the dependency on HZ.
> I rebased the patches against current -mm + John's ntp.c patch.

Hey Roman,
	How much real-world testing have you done with these patches? I've been
running w/ this set of patches for a few days and I've been noticing my
system is having difficulties synching up w/ the NTP server.

I haven't been logging anything, so its currently uncertain data, but
normally I've seen NTP sync the time within 1-2ms in just an hour or so,
however since this morning (~6 hours ago) I'm seeing it still 10ms off.

I'm going to let it run for the rest of the day then try to bisect the
patches to see where things went wrong. I'll let you know as soon as I
find anything.

thanks
-john

