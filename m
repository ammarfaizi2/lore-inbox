Return-Path: <linux-kernel-owner+w=401wt.eu-S932396AbWLNKuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWLNKuI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 05:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWLNKuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 05:50:07 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55407 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932396AbWLNKuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 05:50:06 -0500
Date: Thu, 14 Dec 2006 10:58:09 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Doug Thompson <norsk5@yahoo.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] EDAC: Add Fully-Buffered DIMM APIs to core
Message-ID: <20061214105809.4143be6c@localhost.localdomain>
In-Reply-To: <236399.13106.qm@web50113.mail.yahoo.com>
References: <236399.13106.qm@web50113.mail.yahoo.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +void edac_mc_handle_fbd_ue(struct mem_ctl_info *mci,
> +				unsigned int csrow,
> +				unsigned int channela,
> +				unsigned int channelb,
> +				char *msg)
> +{
> +	int len = EDAC_MC_LABEL_LEN * 4;
> +	char labels[len + 1];

Have you checked gcc generates the right code from this and not a dynamic
allocation. I'm not sure if you want "const int len" to force that ?


Otherwise looks ok
