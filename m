Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWCPXh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWCPXh2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 18:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWCPXh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 18:37:28 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:48547 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751238AbWCPXh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 18:37:27 -0500
To: Greg KH <gregkh@suse.de>
Cc: Mark Maule <maule@sgi.com>, "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, shaohua.li@intel.com
Subject: Re: [PATCH] (-mm) drivers/pci/msi: explicit declaration of msi_register
X-Message-Flag: Warning: May contain useful information
References: <44172F0E.6070708@ce.jp.nec.com>
	<20060314134535.72eb7243.akpm@osdl.org>
	<44176502.9050109@ce.jp.nec.com> <20060315235544.GA6504@suse.de>
	<44198210.6090109@ce.jp.nec.com> <20060316181934.GM13666@sgi.com>
	<4419BD64.5070705@ce.jp.nec.com> <20060316194155.GP13666@sgi.com>
	<20060316232837.GA12408@suse.de>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 16 Mar 2006 15:37:22 -0800
In-Reply-To: <20060316232837.GA12408@suse.de> (Greg KH's message of "Thu, 16 Mar 2006 15:28:37 -0800")
Message-ID: <adalkvaneq5.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Mar 2006 23:37:24.0200 (UTC) FILETIME=[93C5D680:01C64952]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> As msi.c today is pretty platform-specific as is, I don't
    Greg> have a problem with moving the ia64 stuff also into that
    Greg> directory.  Especially as it will help solve issues like
    Greg> this a lot better.

I think we really want to make drivers/pci/msi.c less
platform-specific.  Both powerpc and sparc64 are starting to pay
attention to MSI, so we should really be trying to move things in the
direction of a clean separation of generic MSI handling and
Intel-specific bits.

 - R.
