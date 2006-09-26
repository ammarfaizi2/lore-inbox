Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWIZTEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWIZTEd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 15:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWIZTEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 15:04:33 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:21642 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932457AbWIZTEc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 15:04:32 -0400
Subject: Re: [PATCH] libata-eh: Remove layering violation and duplication
	when	handling absent ports
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <451964E1.4090304@pobox.com>
References: <1159289618.11049.259.camel@localhost.localdomain>
	 <451964E1.4090304@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Sep 2006 20:27:21 +0100
Message-Id: <1159298841.11049.291.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-09-26 am 13:35 -0400, ysgrifennodd Jeff Garzik:
> Alan Cox wrote:
> > This removes the layering violation where drivers have to fiddle
> > directly with EH flags. Instead we now recognize -ENOENT means "no port"
> > and do the handling in the core code.
> > 
> > This also removes an instance of a call to disable the port, and an
> > identical printk from each driver doing this. Even better - future rule
> > changes will be in one place only.
> > 
> > Signed-off-by: Alan Cox <alan@redhat.com>
> 
> applied, but please stop adding trailing whitespace

I will have a further discussion with the source code of the joe editor.
I thought I'd fixed that.

