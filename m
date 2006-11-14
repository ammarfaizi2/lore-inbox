Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966198AbWKNQly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966198AbWKNQly (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 11:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966200AbWKNQly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 11:41:54 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:7363 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S966198AbWKNQlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 11:41:53 -0500
Message-ID: <4559F1CE.9040805@garzik.org>
Date: Tue, 14 Nov 2006 11:41:50 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] libata fixes
References: <20061114150454.GA11900@havoc.gtf.org> <4559EFB2.1000809@rtr.ca>
In-Reply-To: <4559EFB2.1000809@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Any time we return 0 from queuecommand, the SCSI mid-layer expects us
> to also take care of invoking the done() function.  Where does this now
> happen for this case (err_mem) ???

It _already_ happened in the error path of ata_scsi_qc_new(), which is 
why this is a double-completion bug fix.

	Jeff


