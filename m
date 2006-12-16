Return-Path: <linux-kernel-owner+w=401wt.eu-S1161121AbWLPQIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161121AbWLPQIS (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 11:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbWLPQIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 11:08:15 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:34620 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161119AbWLPQIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 11:08:14 -0500
Message-ID: <45841525.7040406@pobox.com>
Date: Sat, 16 Dec 2006 10:47:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pata_via: Cable detect error
References: <20061216143221.47c5e7f3@localhost.localdomain>
In-Reply-To: <20061216143221.47c5e7f3@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> The UDMA66 VIA hardware has no controller side cable detect bits we can
> use. This patch minimally fixes the problem by reporting unknown in this
> case and using drive side detection.
> 
> The old drivers/ide code does some additional tricks but those aren't
> appropriate now we are in -rc.
> 
> Without this update UDMA66 via controllers run slowly. They don't fail so
> it's a borderline call whether this is -rc material or not.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

I think it's #upstream-fixes material (-rc material), and applied as such.

Especially considering that libata pata_* drivers are not the primary 
drivers, I think it's best to forward this type of stuff, especially as 
it is indeed IMO a fix worth having.


