Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWADIlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWADIlg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 03:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWADIlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 03:41:36 -0500
Received: from [81.2.110.250] ([81.2.110.250]:26304 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751217AbWADIlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 03:41:36 -0500
Subject: Re: Ping-Pong Compatible DMA buffer chaining
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Deven Balani <devenbalani@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7a37e95e0601032128l2c7d6e03v742de8dd485af9db@mail.gmail.com>
References: <7a37e95e0512252205t68c6b6f6sfeedf3a75880fda9@mail.gmail.com>
	 <1136250520.13968.5.camel@localhost.localdomain>
	 <7a37e95e0601032128l2c7d6e03v742de8dd485af9db@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Jan 2006 08:43:49 +0000
Message-Id: <1136364229.22598.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-01-04 at 10:58 +0530, Deven Balani wrote:
> My hardware has two Buffers B0 and B1 for both Tx and Rx path.
> I had to fill the first buffer initially and then _continue_ a walk
> through the sg list with help of buffer completion interrupts of B0 &
> B1.

This looks workable to me. You can possibly also use the max_Sectors
field in the sht to simplify the logic by letting the kernel split the
sg entries before they become too large for your hardware.

Alan

