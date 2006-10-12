Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWJLRUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWJLRUn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWJLRUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:20:43 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:34753 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751426AbWJLRUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:20:41 -0400
Message-ID: <452E7966.7030206@garzik.org>
Date: Thu, 12 Oct 2006 13:20:38 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
CC: linux-scsi@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SCSI/qla2xxx: handle sysfs errors
References: <20061012014538.GA12894@havoc.gtf.org> <20061012165734.GG3638@andrew-vasquezs-computer.local>
In-Reply-To: <20061012165734.GG3638@andrew-vasquezs-computer.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Vasquez wrote:
> NACK, please don't do this.  SYSFS entries, albiet important, aren't
> necessarilly critical to a functioning driver.  I'd rather the driver
> not error out.

As discussed before, the only errors thrown are either ENOMEM or EFAULT, 
both of which are quite serious.


> Here's what I had stewing to address the must_check directives and
> qla2xxx:

If you're gonna change it that much, might as well use attribute groups.

	Jeff


