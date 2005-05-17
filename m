Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVEQHRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVEQHRF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 03:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVEQHRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 03:17:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:33244 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261289AbVEQHRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 03:17:00 -0400
Date: Tue, 17 May 2005 00:15:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: mbligh@mbligh.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watchdog config option (was: Re: [PATCH] NMI lockup
 and AltSysRq-P dumping calltraces on _all_ cpus via NMI IPI)
Message-Id: <20050517001542.40e6c6b7.akpm@osdl.org>
In-Reply-To: <42899797.2090702@sw.ru>
References: <42822B5F.8040901@sw.ru>
	<768860000.1116282855@flay>
	<42899797.2090702@sw.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> wrote:
>
> BTW, why NMI watchdog is disabled by default?

There was a significantly large string of reports of dying PCs in the
2.4.early timeframe.  These machines would mysteriously lock up after
considerable periods of time and the problem was cured by disabling the NMI
watchdog.  Nobody was ever able to solve it, so we changed it to default to
off.

So much has changed in there that we might have fixed it by accident, and I
do recall a couple of fundamental and subtle NMI bugs being fixed.  So
yeah, it might be worth enabling it by default again.  Care to send a patch
which does that?
