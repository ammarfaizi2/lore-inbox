Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbUKVQaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUKVQaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbUKVQ2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:28:02 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:23751 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262126AbUKVPmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:42:51 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       netdev@oss.sgi.com
X-Message-Flag: Warning: May contain useful information
References: <20041122714.taTI3zcdWo5JfuMd@topspin.com>
	<20041122714.AyIOvRY195EGFTaO@topspin.com>
	<20041122153144.GA4821@infradead.org>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 22 Nov 2004 07:41:47 -0800
In-Reply-To: <20041122153144.GA4821@infradead.org> (Christoph Hellwig's
 message of "Mon, 22 Nov 2004 15:31:44 +0000")
Message-ID: <52k6sdevr8.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][RFC/v1][11/12] Add InfiniBand Documentation files
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 22 Nov 2004 15:41:52.0696 (UTC) FILETIME=[C9CD9380:01C4D0A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Christoph> Any reason this doesn't use an interface similar to the
    Christoph> normal vlan code?

The normal vlan code uses an ioctl().  I thought a simple sysfs
interface would be more palatable than a new socket ioctl.

    Christoph> And what is a P_Key?

It is a 16-bit identifier carried by IB packets that says which
partition the packet is in.  End ports have P_Key tables that list
which partitions they are members of (a port can be a member of one or
more partitions, and can only receive packets from that partition).

 - Roland
