Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267629AbUHWJxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267629AbUHWJxZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 05:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267635AbUHWJxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 05:53:25 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:54799 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S267629AbUHWJxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 05:53:22 -0400
Date: Mon, 23 Aug 2004 11:53:18 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Stefanos Harhalakis <v13@priest.com>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Reread partition table when a partition is added
Message-ID: <20040823095318.GB2682@pclin040.win.tue.nl>
References: <200408230119.12878.v13@priest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408230119.12878.v13@priest.com>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: dmv.com: mailhost.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 01:19:06AM +0300, Stefanos Harhalakis wrote:

>   This small patch rereads the partition table even if the block device is 
> beeing used. It only rereads it when there are no changes at the current 
> partitions and there are new partitions added at the end. Any existing 
> partition change will/should make it fail.
> 
>   Is it OK and/or useful ?

What you want is possible already today.
For an example, see partx in util-linux.

Andries


[More precisely: rereading the pt consists of (i) reading pt, and
(ii) updating kernel tables. Now (i) can be done from user space,
by fdisk-type programs, and (ii) can be done from user space,
by partx-type programs.]
