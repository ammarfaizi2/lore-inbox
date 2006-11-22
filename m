Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756896AbWKVAL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756896AbWKVAL6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 19:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756897AbWKVAL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 19:11:58 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:6317
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1756896AbWKVAL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 19:11:57 -0500
Date: Tue, 21 Nov 2006 16:11:58 -0800 (PST)
Message-Id: <20061121.161158.63124759.davem@davemloft.net>
To: dev@openvz.org
Cc: linux-kernel@vger.kernel.org, devel@openvz.org
Subject: Re: [SPARC64]: resumable error decoding
From: David Miller <davem@davemloft.net>
In-Reply-To: <45630257.9070308@openvz.org>
References: <45630257.9070308@openvz.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Korotaev <dev@openvz.org>
Date: Tue, 21 Nov 2006 16:42:47 +0300

> Running stress tests on OpenVZ 2.6.18 sparc64 kernel we hit the following:
> ------- cut --------
> [285401.094964] RESUMABLE ERROR: Reporting on cpu 0
> [285401.626736] RESUMABLE ERROR: err_handle[410000000000c6f] err_stick[103921ee2007c] err_type[00000004:warning resumable]
> [285402.869015] RESUMABLE ERROR: err_attrs[00000020:       ]
> [285403.491920] RESUMABLE ERROR: err_raddr[0000000000000000] err_size[0] err_cpu[0]

This is a power-off request, did someone push the power-off button
or give the power-off command from the System Controller console?

I should add proper support for this, this report is a good reminder
:-)

All resumable errors of type 0x4 are power-off requests.
Unfortunately these encodings are not in any of the publicly published
documents.
