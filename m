Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVCBHs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVCBHs7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 02:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVCBHs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 02:48:59 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:31673 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262180AbVCBHs5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 02:48:57 -0500
Subject: Re: [PATCH 2.6.11-rc4-mm1] end-of-proces handling for acct-csa
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Jay Lan <jlan@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Kaigai Kohei <kaigai@ak.jp.nec.com>, jbarnes@sgi.com
In-Reply-To: <4224AF3D.3010803@sgi.com>
References: <421EA8FF.1050906@sgi.com>
	 <20050224204646.704680e9.akpm@osdl.org>
	 <1109314660.1738.206.camel@frecb000711.frec.bull.fr>
	 <42236979.5030702@sgi.com>
	 <1109662409.8594.50.camel@frecb000711.frec.bull.fr>
	 <4224AF3D.3010803@sgi.com>
Date: Wed, 02 Mar 2005 08:48:55 +0100
Message-Id: <1109749735.8422.104.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 02/03/2005 08:57:57,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 02/03/2005 08:58:00,
	Serialize complete at 02/03/2005 08:58:00
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-01 at 10:06 -0800, Jay Lan wrote:
> Sorry I was not clear on my point.
> 
> I was trying to point out that, an exit hook for BSD and CSA is
> essential to save accounting data before the data is gone. That
> can not be done with a netlink.
> 
> So, my patch was to keep acct_process as a wrapper, which
> would then call do_exit_csa() for CSA and call do_acct_process
> for BSD.

Is it possible to merge BSD and CSA? I mean with CSA, there is a part
that does per-process accounting. For exemple in the
linux-2.6.9.acct_mm.patch the two functions update_mem_hiwater() and
csa_update_integrals() update fields in the current (and parent)
process. So maybe you can improve the BSD per-process accounting or
maybe CSA can replace the BSD per-process accounting?

Guillaume  

