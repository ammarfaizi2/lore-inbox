Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbVAEPIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbVAEPIL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 10:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbVAEPIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 10:08:11 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:58553 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262459AbVAEPIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 10:08:06 -0500
Subject: Re: Very high load on P4 machines with 2.4.28
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: indrek.kruusa@tuleriit.ee
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41DBCAE5.9010408@tuleriit.ee>
References: <41DBCAE5.9010408@tuleriit.ee>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104929106.24896.171.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 05 Jan 2005 14:03:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe I am victim of marketing (or poor memory) but wasn't it so that 
> x86 instruction HLT was possible to use for single logical processor?

You can easily park one of the threads ("rep nop" is used as a hint to
give the CPU back to the other thread so

1:	hlt
	rep nop
	jr 1b

ought to do it, but in HT mode other stuff like the cache behaviour is
often changed

