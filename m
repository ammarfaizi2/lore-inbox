Return-Path: <linux-kernel-owner+w=401wt.eu-S1751665AbWLNVB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbWLNVB0 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 16:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbWLNVB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 16:01:26 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57871 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751657AbWLNVBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 16:01:25 -0500
Date: Thu, 14 Dec 2006 13:01:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Doug Thompson <norsk5@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] EDAC: Add Fully-Buffered DIMM APIs to core
Message-Id: <20061214130121.53a1776d.akpm@osdl.org>
In-Reply-To: <20061214105809.4143be6c@localhost.localdomain>
References: <236399.13106.qm@web50113.mail.yahoo.com>
	<20061214105809.4143be6c@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 10:58:09 +0000
Alan <alan@lxorguk.ukuu.org.uk> wrote:

> > +void edac_mc_handle_fbd_ue(struct mem_ctl_info *mci,
> > +				unsigned int csrow,
> > +				unsigned int channela,
> > +				unsigned int channelb,
> > +				char *msg)
> > +{
> > +	int len = EDAC_MC_LABEL_LEN * 4;
> > +	char labels[len + 1];
> 
> Have you checked gcc generates the right code from this and not a dynamic
> allocation. I'm not sure if you want "const int len" to force that ?

gcc does the right thing.  gcc-4.0.2 on x86_64, at least.
