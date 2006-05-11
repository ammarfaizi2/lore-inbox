Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWEKS3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWEKS3K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 14:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWEKS3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 14:29:10 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:9105 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1750804AbWEKS3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 14:29:08 -0400
X-IronPort-AV: i="4.05,116,1146466800"; 
   d="scan'208"; a="1804588845:sNHT116047920"
To: "Or Gerlitz" <or.gerlitz@gmail.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       michaelc@cs.wisc.edu, James.Bottomley@SteelEye.com
Subject: Re: [openib-general] [PATCH 6/6] iSER Kconfig and Makefile
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.44.0605111003160.18975-100000@zuben>
	<adau07w1nks.fsf@cisco.com>
	<15ddcffd0605111124v390e1dbei18508787ec29afac@mail.gmail.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 11 May 2006 11:29:06 -0700
In-Reply-To: <15ddcffd0605111124v390e1dbei18508787ec29afac@mail.gmail.com> (Or Gerlitz's message of "Thu, 11 May 2006 20:24:09 +0200")
Message-ID: <adaejz01klp.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 May 2006 18:29:07.0190 (UTC) FILETIME=[C9D41960:01C67528]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Or> Indeed since libiscsi does not have a CONFIG_ of its own, you
    Or> need to set CONFIG_ISCSI_TCP to have libiscsi being built and
    Or> then iser links with it.

    Or> So there are two options here: either to set a CONFIG_LIBISCSI
    Or> and select it by both CONFIG_ISCSI_TCP and
    Or> CONFIG_INFINIBAND_ISER or the approach you were suggesting. I
    Or> am cc-ing Mike Christie and James Bottomley on this email, if
    Or> you guys have a preference, let me know and i can produce a
    Or> patch to drivers/scsi/Kconfig and Makefile.

In the iser branch of my git tree I just added

    obj-$(CONFIG_INFINIBAND_ISER)   += libiscsi.o

to drivers/scsi/Makefile.  So let me know if I should change that.

    Or> Thanks to you for pointing these issues, also, in
    Or> drivers/infiniband/Makefile

    >> +obj-$(CONFIG_INFINIBAND_SRP) += ulp/iser/

    Or> should be

    >> +obj-$(CONFIG_INFINIBAND_ISER) += ulp/iser/

Thanks, I made a copy-and-paste error there.  I pushed out a fixed tree.

 - R.
