Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVEQOCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVEQOCe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 10:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVEQOCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 10:02:34 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:21429 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261303AbVEQOBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 10:01:42 -0400
Date: Tue, 17 May 2005 07:01:40 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@sw.ru>
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watchdog config option (was: Re: [PATCH] NMI lockup and AltSysRq-P dumping calltraces on _all_ cpus via NMI IPI)
Message-ID: <293160000.1116338500@[10.10.2.4]>
In-Reply-To: <20050517001542.40e6c6b7.akpm@osdl.org>
References: <42822B5F.8040901@sw.ru><768860000.1116282855@flay><42899797.2090702@sw.ru> <20050517001542.40e6c6b7.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Andrew Morton <akpm@osdl.org> wrote (on Tuesday, May 17, 2005 00:15:42 -0700):

> Kirill Korotaev <dev@sw.ru> wrote:
>> 
>> BTW, why NMI watchdog is disabled by default?
> 
> There was a significantly large string of reports of dying PCs in the
> 2.4.early timeframe.  These machines would mysteriously lock up after
> considerable periods of time and the problem was cured by disabling the NMI
> watchdog.  Nobody was ever able to solve it, so we changed it to default to
> off.
> 
> So much has changed in there that we might have fixed it by accident, and I
> do recall a couple of fundamental and subtle NMI bugs being fixed.  So
> yeah, it might be worth enabling it by default again.  Care to send a patch
> which does that?

There are some unfixable machine issues - for instance, the IBM
Netfinity 8500R corrupts one of the registers (ebx?) every time we get
an NMI for us, and panics. Probably other boxes you mention above have
similar issues? But it's not our code that's at fault ...

In light of this, I don't think it's a good idea to enable NMI by default,
at least not without a blacklist function of some sort?

M.

