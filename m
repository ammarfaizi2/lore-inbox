Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753376AbWKFQZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbWKFQZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753377AbWKFQZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:25:40 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:63966 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1753376AbWKFQZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:25:38 -0500
In-Reply-To: <20061106145839.GA9387@osiris.boeblingen.de.ibm.com>
Subject: Re: [PATCH 2.6.19 1/4] ehca: assure 4k alignment for firmware control block
 in 64k page mode
To: heicars2@de.ibm.com
Cc: Christoph Raisch <raisch@de.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, openib-general@openib.org, rolandd@cisco.com
X-Mailer: Lotus Notes Release 7.0 HF277 June 21, 2006
Message-ID: <OF04898E66.3051E8D8-ONC125721E.0058993B-C125721E.0058DF2C@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Mon, 6 Nov 2006 17:13:44 +0100
X-MIMETrack: Serialize by Router on D12ML065/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 06/11/2006 17:28:20
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

heicars2@de.ltcfwd.linux.ibm.com wrote on 06.11.2006 15:58:39:
> Maybe you want to make sure that ehca_alloc_fw_ctrlblock() always returns
a
> void pointer, so you can avoid all the casts in your code?
> static inline void *ehca_alloc_fw_ctrlblock(void)
> {
>    return (void *)get_zeroed_page(GFP_KERNEL);
> }
Yes, good point. That helps to avoid different warnings between
4k and 64k page modes.
Thx
Nam

