Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966248AbWKNSLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966248AbWKNSLL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 13:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966247AbWKNSLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 13:11:10 -0500
Received: from rtr.ca ([64.26.128.89]:40203 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S966242AbWKNSLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 13:11:09 -0500
Message-ID: <455A06BB.8020002@rtr.ca>
Date: Tue, 14 Nov 2006 13:11:07 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] libata fixes
References: <20061114150454.GA11900@havoc.gtf.org> <4559EFB2.1000809@rtr.ca> <4559F1CE.9040805@garzik.org>
In-Reply-To: <4559F1CE.9040805@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Mark Lord wrote:
>> Any time we return 0 from queuecommand, the SCSI mid-layer expects us
>> to also take care of invoking the done() function.  Where does this now
>> happen for this case (err_mem) ???
> 
> It _already_ happened in the error path of ata_scsi_qc_new(), which is 
> why this is a double-completion bug fix.

Ack. 
