Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWGCWnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWGCWnT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWGCWnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:43:18 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:14791 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751155AbWGCWnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:43:18 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Ian Turner <vectro@vectro.org>
Subject: Re: waiting for MNT_DETACH
Date: Tue, 4 Jul 2006 00:43:10 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200607021451.24595.vectro@vectro.org>
In-Reply-To: <200607021451.24595.vectro@vectro.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607040043.11868.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Sunday, 2. July 2006 20:51, Ian Turner wrote:
> I administer a two-node high-availability cluster using DRBD and heartbeat. 
> 
> So, here's the question: Is there a way to check if a call to umount2(..., 
> MNT_DETACH) has completed or not?

Check the usage count (refcount) of the DRBD module. It should be as low as
you would expect with a normal umount.

"cat /sys/module/drbd/refcnt" should be the right command.


Regards

Ingo Oeser
