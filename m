Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbUJ3BiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbUJ3BiS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 21:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbUJ2ThT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:37:19 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:30272 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261172AbUJ2Sob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:44:31 -0400
To: Greg KH <greg@kroah.com>
Cc: Klaus Dittrich <kladit@t-online.de>,
       linux mailing-list <linux-kernel@vger.kernel.org>
X-Message-Flag: Warning: May contain useful information
References: <20041027115943.GA1674@xeon2.local.here>
	<52pt32ywwg.fsf@topspin.com> <20041029043807.GA12309@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 29 Oct 2004 11:44:29 -0700
In-Reply-To: <20041029043807.GA12309@kroah.com> (Greg KH's message of "Thu,
 28 Oct 2004 23:38:07 -0500")
Message-ID: <52hdodxt2q.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH] kobject hotplug: don't let SEQNUM overwrite other vars
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 29 Oct 2004 18:44:30.0566 (UTC) FILETIME=[5349D860:01C4BDE7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> No, this puts back the problem where if the hotplug()
    Greg> subsystem call fails, we have already incremented the seqnum
    Greg> without emitting a call with that number.

    Greg> Now I know userspace needs to handle this properly anyway,
    Greg> but we might as well get the kernel right, and not do stuff
    Greg> to make userspace unhappy if we can obviously help it.

Got it... I had remembered you saying gaps in the sequence numbers
were OK in the past.

 - R.
