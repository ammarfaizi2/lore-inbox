Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVEKIu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVEKIu0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 04:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVEKIuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 04:50:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49066 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261930AbVEKItg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 04:49:36 -0400
Subject: Re: [patch 2.6.12-rc3] dell_rbu: New Dell BIOS update driver
From: Arjan van de Ven <arjan@infradead.org>
To: Abhay Salunke <Abhay_Salunke@dell.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       matt_domsch@dell.com
In-Reply-To: <20050510220520.GA30741@littleblue.us.dell.com>
References: <20050510220520.GA30741@littleblue.us.dell.com>
Content-Type: text/plain
Date: Wed, 11 May 2005 10:49:32 +0200
Message-Id: <1115801373.6029.24.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-10 at 17:05 -0500, Abhay Salunke wrote:
> The dell_rbu driver is required for updating BIOS on DELL servers and client
> systems. The driver lets a user application download the BIOS image in to
> contiguous physical memory pages; the driver exposes the memory via sysfs
> filesystem. The update mechanism basically has two approcahes; one by
> allocating contiguous physical memory and the second approach is by allocating
> small chunks of contiguous physical memory.
> 
> The patch file is attached to this mail.

I wonder if this wouldn't be able to use the request_firmware()
interface instead... I mean, it would simplify the sysfs code a lot I
suspect. 

