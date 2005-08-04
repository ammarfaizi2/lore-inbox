Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVHDExT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVHDExT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 00:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVHDEvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 00:51:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37565 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261817AbVHDEtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 00:49:19 -0400
Date: Thu, 4 Aug 2005 00:49:11 -0400
From: Dave Jones <davej@redhat.com>
To: "Saripalli, Venkata Ramanamurthy (STSD)" <saripalli@hp.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH 1/2] cpqfc: fix for "Using too much stach" in 2.6 kernel
Message-ID: <20050804044911.GB26949@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Saripalli, Venkata Ramanamurthy (STSD)" <saripalli@hp.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	axboe@suse.de
References: <4221C1B21C20854291E185D1243EA8F302623BCC@bgeexc04.asiapacific.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4221C1B21C20854291E185D1243EA8F302623BCC@bgeexc04.asiapacific.cpqcorp.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 10:09:51AM +0530, Saripalli, Venkata Ramanamurthy (STSD) wrote:
 > -          ULONG ulFibreFrame[2048/4];  // max DWORDS in incoming FC

This is 512 ulongs, which is 2KB.

 > +	  ulFibreFrame = kmalloc((2048/4), GFP_KERNEL);

You're replacing it with a 512 byte buffer.

		Dave

