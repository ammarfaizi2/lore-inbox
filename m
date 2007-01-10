Return-Path: <linux-kernel-owner+w=401wt.eu-S965118AbXAJVdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbXAJVdz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 16:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbXAJVdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 16:33:55 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:12100 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965118AbXAJVdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 16:33:54 -0500
X-IronPort-AV: i="4.13,168,1167638400"; 
   d="scan'208"; a="355590805:sNHT42367288"
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [kvm-devel] guest crash on 2.6.20-rc4
X-Message-Flag: Warning: May contain useful information
References: <ada4pr1mqz2.fsf@cisco.com> <45A40898.4040307@qumranet.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 10 Jan 2007 13:33:47 -0800
In-Reply-To: <45A40898.4040307@qumranet.com> (Avi Kivity's message of "Tue, 09 Jan 2007 23:26:48 +0200")
Message-ID: <ada8xgay3b7.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Jan 2007 21:33:50.0226 (UTC) FILETIME=[04A02F20:01C734FF]
Authentication-Results: sj-dkim-4; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >  	if (is_writeble_pte(*shadow_ent))
 > -		return 0;
 > +		return 1;

With this patch, it looks like my guest is surviving the load that
triggered the oops before.  So I think this fixes the issue I saw as well.
I assume you'll send this in for 2.6.20?

 - R.
