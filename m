Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVDZO05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVDZO05 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 10:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVDZO05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 10:26:57 -0400
Received: from pat.uio.no ([129.240.130.16]:234 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261577AbVDZO0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 10:26:19 -0400
Subject: Re: filesystem transactions API
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ville Herva <v@iki.fi>
Cc: Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050426134629.GU16169@viasys.com>
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk>
	 <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com>
	 <20050426134629.GU16169@viasys.com>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 10:25:57 -0400
Message-Id: <1114525558.28850.15.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.532, required 12,
	autolearn=disabled, AWL 1.42, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 26.04.2005 Klokka 16:46 (+0300) skreiv Ville Herva:
> Apparently, Windows Longhorn will include something called "transactional
> NTFS". It's explained pretty well in
> 
>    http://blogs.msdn.com/because_we_can/
> 
> Basically, a process can create a fs transaction, and all fs changes made
> between start of the transaction and commit are atomical - meaning nothing
> is visible until commit, and if commit fails, everything is rolled back.
> 
> Sound useful... Although there are no service pack installs that could fail
> in Linux, the same thing could be useful in rpm, yum, almost anything. 
> 
> What do you think?

NetApp have implemented something similar in their DAFS filesystem
called "rollback locks" (or autorecover locks).

   http://www.watersprings.org/pub/id/draft-wittle-dafs-00.txt

Very useful for database apps etc.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

