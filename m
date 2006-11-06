Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423692AbWKFJ5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423692AbWKFJ5M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 04:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423694AbWKFJ5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 04:57:12 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:14698 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423692AbWKFJ5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 04:57:11 -0500
In-Reply-To: <200611060045.59074.arnd@arndb.de>
Subject: Re: [PATCH 2.6.19 1/4] ehca: assure 4k alignment for firmware control block
 in 64k page mode
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Raisch <raisch@de.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, openib-general@openib.org, rolandd@cisco.com
X-Mailer: Lotus Notes Release 7.0 HF277 June 21, 2006
Message-ID: <OF478DD9AF.FCA98729-ONC125721E.0031F840-C125721E.0036A811@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Mon, 6 Nov 2006 11:00:00 +0100
X-MIMETrack: Serialize by Router on D12ML065/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 06/11/2006 11:00:08
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,
> This seems broken. You have a constructor for newly allocated objects,
but
> there is no destructor and it seems that objects passed to
> ehca_free_fw_ctrlblock are not guaranteed to be initialized either.
> I'd simply move the memset into the alloc function and get rid of the
> constructor here.
Yep, I was not aware that ctor is not called for every
kmem_cache_alloc(). Thx for pointing this out.
Nam

