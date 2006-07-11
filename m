Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWGKWEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWGKWEQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWGKWEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:04:16 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:4012 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932177AbWGKWEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:04:15 -0400
Message-ID: <44B4205D.1050407@garzik.org>
Date: Tue, 11 Jul 2006 18:04:13 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: linux-ide@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17] ata_piix device probe fixes
References: <20060711214923.GA20652@havoc.gtf.org>
In-Reply-To: <20060711214923.GA20652@havoc.gtf.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> +static void piix_host_stop(struct ata_host_set *host_set)
> +{
> +	kfree(host_set->private_data);
> +	ata_host_stop(host_set);

Crap, this introduces a double-kfree.  Fix pending...

	Jeff



