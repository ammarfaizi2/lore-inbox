Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265267AbUF1Wkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265267AbUF1Wkv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 18:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUF1Wkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 18:40:51 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:59981 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S265267AbUF1Wkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 18:40:47 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Scott Wood <scott@timesys.com>, oliver@neukum.org, zaitcev@redhat.com,
       greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com,
       tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
Subject: Re: drivers/block/ub.c
X-Message-Flag: Warning: May contain useful information
References: <20040626130645.55be13ce@lembas.zaitcev.lan>
	<20040628141517.GA4311@yoda.timesys>
	<20040628132531.036281b0.davem@redhat.com>
	<200406282257.11026.oliver@neukum.org>
	<20040628140343.572a0944.davem@redhat.com>
	<20040628211857.GA5508@yoda.timesys>
	<20040628152208.20fe97f1.davem@redhat.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 28 Jun 2004 15:40:45 -0700
In-Reply-To: <20040628152208.20fe97f1.davem@redhat.com> (David S. Miller's
 message of "Mon, 28 Jun 2004 15:22:08 -0700")
Message-ID: <52oen3tifm.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 28 Jun 2004 22:40:45.0936 (UTC) FILETIME=[F3A86700:01C45D60]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> Try it out if you don't believe someone who has maintained
    David> the Linux networking for 7 years and sits on the GCC
    David> Steering Committee.  :-)

Just so I'm sure I'm not misunderstanding, are you promising me that I
will never get bitten on the ass on any architecture with kernel code
that assumes the compiler will never add padding as long as struct
fields are naturally aligned to their size? :-)

For example, you're saying I'm definitely safe declaring a structure
(used as a HW descriptor) like say

	struct mthca_qp_path {
		u32 port_pkey;
		u8  rnr_retry;
		u8  g_mylmc;
		u16 rlid;
		u8  ackto;
		u8  mgid_index;
		u8  static_rate;
		u8  hop_limit;
		u32 sl_tclass_flowlabel;
		u8  rgid[16];
	};

without __attribute__((packed))?  (Of course I'll only use this struct
aligned to its size)

Thanks,
  Roland
