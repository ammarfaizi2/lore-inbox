Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWIZRff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWIZRff (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWIZRff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:35:35 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:56969 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932172AbWIZRfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:35:32 -0400
Message-ID: <451964E1.4090304@pobox.com>
Date: Tue, 26 Sep 2006 13:35:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata-eh: Remove layering violation and duplication
 when	handling absent ports
References: <1159289618.11049.259.camel@localhost.localdomain>
In-Reply-To: <1159289618.11049.259.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> This removes the layering violation where drivers have to fiddle
> directly with EH flags. Instead we now recognize -ENOENT means "no port"
> and do the handling in the core code.
> 
> This also removes an instance of a call to disable the port, and an
> identical printk from each driver doing this. Even better - future rule
> changes will be in one place only.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied, but please stop adding trailing whitespace


