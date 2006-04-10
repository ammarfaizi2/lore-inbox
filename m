Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWDJPdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWDJPdW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 11:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWDJPdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 11:33:22 -0400
Received: from ozlabs.org ([203.10.76.45]:37065 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751079AbWDJPdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 11:33:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17466.31399.460490.55191@cargo.ozlabs.ibm.com>
Date: Tue, 11 Apr 2006 01:32:55 +1000
From: Paul Mackerras <paulus@samba.org>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kkeil@suse.de
Subject: Re: [Patch] Static overruns in drivers/isdn/i4l/isdn_ppp.c
In-Reply-To: <1144615624.23502.4.camel@alice>
References: <1144615624.23502.4.camel@alice>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sesterhenn writes:

> coverity found some static overruns in isdn_ppp.c (bug id #519)
> At several places slot is compared <0 and > ISDN_MAX_CHANNELS
> and then used to index ippp_table[ISDN_MAX_CHANNELS]
> A value of slot = ISDN_MAX_CHANNELS would run over the end
> of the array.

isdn_ppp.c is not code I maintain, nor does it use the generic PPP
infrastructure I maintain.  Please send patches for this file to
Karsten Keil <kkeil@suse.de>.

Paul.
