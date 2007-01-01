Return-Path: <linux-kernel-owner+w=401wt.eu-S1754721AbXAAXIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721AbXAAXIg (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 18:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbXAAXIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 18:08:36 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:55191
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754621AbXAAXIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 18:08:35 -0500
Date: Mon, 01 Jan 2007 15:08:31 -0800 (PST)
Message-Id: <20070101.150831.17863014.davem@davemloft.net>
To: segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, devel@laptop.org, dmk@flex.com,
       wmb@firmworks.com, hch@infradead.org, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <385664dfd55cfdfb9f9651fc90bf46b0@kernel.crashing.org>
References: <445cb4c27a664491761ce4e219aa0960@kernel.crashing.org>
	<20070101.005714.35017753.davem@davemloft.net>
	<385664dfd55cfdfb9f9651fc90bf46b0@kernel.crashing.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Mon, 1 Jan 2007 18:48:33 +0100

> If you *really* want (the option of) showing things as text
> in the filesystem, you better make it so that there is a
> one-to-one translation back to binary.  For example, what
> does this mean, is it a text string or two bytes:
> 
> 01.02
> 
> Yes you as a user can guess, but scripts can't (reliably).

We have some extensive code in fs/openpromfs/inode.c that
determines whether a property is text or not.  I can't
guarentee it works %100, but it's very context dependant
(only the driver "knows") but it works for all the cases
I've tried.

I really think you're making a mountain out of a mole hill, to be
honest :-)
