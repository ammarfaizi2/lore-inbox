Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965224AbVKPDsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbVKPDsa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbVKPDs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:48:29 -0500
Received: from rtr.ca ([64.26.128.89]:48273 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S965221AbVKPDs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:48:29 -0500
Message-ID: <437AAC0B.80106@rtr.ca>
Date: Tue, 15 Nov 2005 22:48:27 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
References: <20051114195717.GA24373@havoc.gtf.org> <20051115074148.GA17459@htj.dyndns.org> <4379AA5B.1060900@pobox.com> <4379E5F7.6000107@gmail.com> <4379EC82.1030509@pobox.com> <437AA1A0.6080409@gmail.com> <437AA51A.6000709@pobox.com>
In-Reply-To: <437AA51A.6000709@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>
> My setup works without it, successfully burning CDs and DVDs, but has 
> problems with really long commands, and such those which occur when 
> cdrecord(1) finishes a CD burn, and performs its "fixating" step.

Is this just a case of too-short of a SCSI timeout on CLOSE_TRACK?
Drivers I have worked on for this generally apply a 2 minute timeout
for that particular operation, and never have to retry.

Cheers
