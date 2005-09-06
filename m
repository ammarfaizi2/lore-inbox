Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbVIFWnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbVIFWnS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 18:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbVIFWnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 18:43:17 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:16528 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751084AbVIFWnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 18:43:17 -0400
Subject: Re: [PATCH] PCI: Unhide SMBus on Compaq Evo N620c
From: Lee Revell <rlrevell@joe-job.com>
To: Rumen Ivanov Zarev <rzarev@its.caltech.edu>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <200509062039.j86KdWMr014934@inky.its.caltech.edu>
References: <200509062039.j86KdWMr014934@inky.its.caltech.edu>
Content-Type: text/plain
Date: Tue, 06 Sep 2005 18:43:10 -0400
Message-Id: <1126046590.13159.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-06 at 13:39 -0700, Rumen Ivanov Zarev wrote:
> Trivial patch against 2.6.13 to unhide SMBus on Compaq Evo N620c laptop using
> Intel 82855PM chipset.

> +	} else if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_COMPAQ)) {

Should unlikely() be used for cases where the conditional will be true
iff a specific piece of hardware is present?  Seems like we'd always
lose.

Lee


