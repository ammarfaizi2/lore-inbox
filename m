Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265170AbUFROTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbUFROTT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 10:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265168AbUFROTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 10:19:19 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:27555 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265170AbUFROTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 10:19:10 -0400
Subject: Re: Proposal for new generic device API: dma_get_required_mask()
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20040618055909.GA13007@sgi.com>
References: <1087481331.2210.27.camel@mulgrave> 
	<20040618055909.GA13007@sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Jun 2004 09:19:00 -0500
Message-Id: <1087568345.2135.10.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 00:59, Jeremy Higdon wrote:
> Sounds good.  But I'm curious why you make the driver call dma_set_mask()
> twice.

Basically so that dma_get_required_mask() returns a value that may be
related to the current mask.  If the device has a wierd mask setting
(say it has bits missing or something), the platform may want to return
something different to tune the required mask to be optimal.

James


