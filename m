Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVCAHeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVCAHeF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 02:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVCAHeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 02:34:04 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:58282 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261291AbVCAHdu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 02:33:50 -0500
Subject: Re: [PATCH 2.6.11-rc4-mm1] end-of-proces handling for acct-csa
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Jay Lan <jlan@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Kaigai Kohei <kaigai@ak.jp.nec.com>, jbarnes@sgi.com
In-Reply-To: <42236979.5030702@sgi.com>
References: <421EA8FF.1050906@sgi.com>
	 <20050224204646.704680e9.akpm@osdl.org>
	 <1109314660.1738.206.camel@frecb000711.frec.bull.fr>
	 <42236979.5030702@sgi.com>
Date: Tue, 01 Mar 2005 08:33:29 +0100
Message-Id: <1109662409.8594.50.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 01/03/2005 08:42:30,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 01/03/2005 08:42:37,
	Serialize complete at 01/03/2005 08:42:37
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-28 at 10:56 -0800, Jay Lan wrote:
> The exit hook is essential for CSA to save off data before the data
> is gone, A netlink type of thing does not help. BSD is in the same
> situation. You can not replace the acct_process() call with a netlink.
> If ELSA is to use the enhanced accounting data, it needs the CSA
> eop handling at exit as well.

Why replace the acct_process()? The problem here is to add a new hook in
the do_fork() and you can use the BSD accounting hook acct_process()
which is already in the exit() routine. We don't need to replace it with
a netlink because today there are no user space applications that need
it. 

Best regards,
Guillaume 

