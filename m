Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266208AbUFPHZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUFPHZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 03:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUFPHZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 03:25:56 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:49959 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S266207AbUFPHZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 03:25:38 -0400
Subject: Re: PROBLEM: Heavy iowait on 2.6 kernels
From: Guy Van Sanden <n.b@myrealbox.com>
To: Clint Byrum <cbyrum@spamaps.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1087366549.1190.6.camel@lancelot>
References: <1086942905.10540.69.camel@cronos.home.vsb>
	 <1087366549.1190.6.camel@lancelot>
Content-Type: text/plain
Message-Id: <1087369893.11205.36.camel@cronos.home.vsb>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 16 Jun 2004 09:25:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My machine is heavily used for all kinds of file serving (mainly nfs),
but also samba.
Next to that, it is my home-server, so it runs apache2 (tuned to server
only few clients), imap (cyrus), postfix, bugzilla (mysql) and distcc
(used only a few times a week).
It replaces a FreeBSD system (PII-333) running the same except distcc.
Under 

The disk system is just a regular IDE disk (udma5) (60GB) and one
external drive over USB2 (160 GB).  The external drive is rather slow
(20-30 MB/sec), so I disabled it during the tests.

The weird thing is that I see this problem too when only running bonnie.
A friend of mine tried that too under 2.6.6, his iowait went up to
0.15%, mine to 99%.




On Wed, 2004-06-16 at 08:15, Clint Byrum wrote:
> On Fri, 2004-06-11 at 01:35, Guy Van Sanden wrote:
> > I recently discovered why my new Gentoo server slows to a crawl on a
> > intermediate load on the 2.6 kernel series.  The reason seems to be an
> > unusual amount of iowait.
> 
> This appears similar to the problem both myself and Phy Prahbab reported
> about 2.6 and hitting the disks too often. 
> 
> I'm wondering, what kind of workload does your machine see, and what
> sort of disk system is in it?
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
______________________________________________________________________  

  Guy Van Sanden 
  http://unixmafia.port5.com  

  Registered Linux user #249404 - September 1997
______________________________________________________________________

