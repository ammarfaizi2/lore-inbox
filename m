Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbUKWXds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbUKWXds (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 18:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUKWXbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 18:31:40 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:57270 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261190AbUKWXbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 18:31:20 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Message-Flag: Warning: May contain useful information
References: <20041123814.rXLIXw020elfd6Da@topspin.com>
	<20041123814.m1N7Tf2QmSCq9s5q@topspin.com>
	<20041123172256.GA30264@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 23 Nov 2004 15:31:10 -0800
In-Reply-To: <20041123172256.GA30264@kroah.com> (Greg KH's message of "Tue,
 23 Nov 2004 09:22:56 -0800")
Message-ID: <52mzx82ldt.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][RFC/v2][2/21] Add core InfiniBand support
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 23 Nov 2004 23:31:16.0240 (UTC) FILETIME=[86FF1900:01C4D1B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just checked in a change that converts this file from using RCU
to protecting its structures with an rwlock_t.  This should avoid any
patent licensing issues.  These functions are extremely unlikely to
have SMP scalability issues so this isn't too painful.

Thanks,
  Roland

