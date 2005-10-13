Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbVJMM04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbVJMM04 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 08:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbVJMM04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 08:26:56 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:58548 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751004AbVJMM0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 08:26:55 -0400
Subject: Re: SCSI "asking for cache data failed"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcin Owsiany <marcin@owsiany.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051013104536.GA10525@kufelek>
References: <20051013104536.GA10525@kufelek>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Oct 2005 13:55:54 +0100
Message-Id: <1129208154.18635.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-10-13 at 12:45 +0200, Marcin Owsiany wrote:
> I'm wondering about the following messages, which appeared when I upgraded from
> 2.4 to 2.6:
> 
> | sda: asking for cache data failed
> | sda: assuming drive cache: write through
> 
> (a larger log snippet below)

The kernel asks the SCSI drive for its cache parameters. The AMI raid
card sitting in the middle doesn't know how to handle this so this
message occurs. It should be ok providing the raid card itself is
handling the consistency correctly but check with your card vendor.

