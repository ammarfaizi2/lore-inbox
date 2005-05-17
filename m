Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVEQFr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVEQFr5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 01:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVEQFr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 01:47:57 -0400
Received: from ercist.iscas.ac.cn ([159.226.5.94]:16910 "EHLO
	ercist.iscas.ac.cn") by vger.kernel.org with ESMTP id S261164AbVEQFrx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 01:47:53 -0400
Subject: RE: [RFD] What error should FS return when I/O failure occurs?
From: fs <fs@ercist.iscas.ac.cn>
To: "Hua Zhong (hzhong)" <hzhong@cisco.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Kenichi Okuyama <okuyama@intellilink.co.jp>
In-Reply-To: <75D9B5F4E50C8B4BB27622BD06C2B82B2264F6@xmb-sjc-235.amer.cisco.com>
References: <75D9B5F4E50C8B4BB27622BD06C2B82B2264F6@xmb-sjc-235.amer.cisco.com>
Content-Type: text/plain
Organization: iscas
Message-Id: <1116348944.2428.42.camel@CoolQ>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 17 May 2005 12:55:44 -0400
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 01:36, Hua Zhong (hzhong) wrote:
> > What you said is based on the FS implementor's perspective.
> > But from user's perspective, they open a file with O_RDWR, get a
> > success, then write returns EROFS?
> > Besides, EXT3 ALWAYS return EROFS for the 1st and 2nd case, even
> > you specify errors=continue, things are still the same.
> 
> Which version of kernel you are using?
My test environment is based on 2.6.11 kernel
> It was probably the case in kernel before 2.4.20. The old ext3 had a
> problem that it ignored IO error at journal commit time. I submitted a
> patch to fix that around the time of 2.4.20. 2.6 should be fine too,
> unless someone else broke it again.
> 
> Hua


