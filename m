Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVB1HsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVB1HsG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 02:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVB1HsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 02:48:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:9440 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261215AbVB1HsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 02:48:03 -0500
Subject: Re: updating mtime for char/block devices?
From: Arjan van de Ven <arjan@infradead.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42225CEE.1030104@gmx.net>
References: <42225CEE.1030104@gmx.net>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 08:47:58 +0100
Message-Id: <1109576878.6298.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-28 at 00:51 +0100, Carl-Daniel Hailfinger wrote:
> Hi,
> 
> is it intentional that
> echo foo >/dev/hda1
> doesn't update the mtime of the device node, but
> echo foo >/dev/tty10
> does update the mtime of the device node?
> 
> And no, mounting with the noatime flag doesn't help because the
> mtime is updated. IIRC some time ago this behaviour was different,
> but I could easily be mistaken.

devices are tricky in general in this respect, /dev may be mounted read
only for example ;)


