Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129054AbRBNLzD>; Wed, 14 Feb 2001 06:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131627AbRBNLyn>; Wed, 14 Feb 2001 06:54:43 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:16959 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129054AbRBNLyk>; Wed, 14 Feb 2001 06:54:40 -0500
Date: Wed, 14 Feb 2001 05:54:34 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] network driver updates
In-Reply-To: <3A8A7159.AF0E6180@colorfullife.com>
Message-ID: <Pine.LNX.3.96.1010214055331.12910R-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Manfred Spraul wrote:
> * dev->mem_start: NULL means "not command line configuration" 0xffffffff
> means "default".
> several drivers only check for NULL, not for 0xffffffff.

netdev->mem_start is unsigned long... Should the test be for ~0 instead?
The value 0xFFFFFFFF seems wrong for 64-bit machines.

	Jeff




