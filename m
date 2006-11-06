Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWKFKgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWKFKgZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 05:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWKFKgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 05:36:24 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:46445 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750807AbWKFKgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 05:36:24 -0500
In-Reply-To: <200611060045.59074.arnd@arndb.de>
Subject: Re: [PATCH 2.6.19 1/4] ehca: assure 4k alignment for firmware control block
 in 64k page mode
To: rolandd@cisco.com
Cc: Christoph Raisch <raisch@de.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, openib-general@openib.org,
       Arnd Bergmann <arnd@arndb.de>
X-Mailer: Lotus Notes Release 7.0 HF277 June 21, 2006
Message-ID: <OF69697CF5.13DC8781-ONC125721E.0039CD42-C125721E.003A3D50@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Mon, 6 Nov 2006 11:39:09 +0100
X-MIMETrack: Serialize by Router on D12ML065/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 06/11/2006 11:39:15
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roland!
> Arnd wrote:
> This seems broken. You have a constructor for newly allocated objects,
but
> there is no destructor and it seems that objects passed to
> ehca_free_fw_ctrlblock are not guaranteed to be initialized either.
> I'd simply move the memset into the alloc function and get rid of the
> constructor here.
As Arnd stated I need to fix this ctor issue. Do you prefer me to resend
all patches in proper format (non-mangled inline) or just this one bug fix?
Thanks!
Nam

