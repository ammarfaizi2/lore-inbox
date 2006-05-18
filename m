Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWERPg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWERPg5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWERPg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:36:57 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:12675 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750737AbWERPg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:36:56 -0400
Message-ID: <446C9492.2040704@garzik.org>
Date: Thu, 18 May 2006 11:36:50 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Jan Wagner <jwagner@kurp.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: support for sata7 Streaming Feature Set?
References: <Pine.LNX.4.58.0605051547410.7359@kurp.hut.fi> <4466D6FB.1040603@gmail.com> <Pine.LNX.4.58.0605162126520.31191@kurp.hut.fi> <446BD8F2.10509@gmail.com>
In-Reply-To: <446BD8F2.10509@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> One thing to think about before supporting streaming from/to harddisks 
> from userland is how to make data flow efficiently from userland to 
> kernel and back.  But, no matter what, kernel <-> userland usually 
> involves one data copy, so I don't think making sg similarly efficient 
> would be too difficult (it might be already).

Actually, the kernel usually maps userland pages, eliminating the need 
for a copy.  write(2) may have copied data into that page originally, 
but mmap(2) need not have.

	Jeff


