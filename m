Return-Path: <linux-kernel-owner+w=401wt.eu-S932107AbXAOI51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbXAOI51 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 03:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbXAOI51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 03:57:27 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:20889
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932107AbXAOI50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 03:57:26 -0500
Message-Id: <45AB5065.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 15 Jan 2007 08:59:01 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Jeremy Fitzhardinge" <jeremy@goop.org>, "Andrew Morton" <akpm@osdl.org>
Cc: <virtualization@lists.osdl.org>, <xen-devel@lists.xensource.com>,
       "Andi Kleen" <ak@muc.de>, "Rusty Russell" <rusty@rustcorp.com.au>,
       "Chris Wright" <chris@sous-sol.org>, <linux-kernel@vger.kernel.org>,
       "Zachary Amsden" <zach@vmware.com>
Subject: Re: [Xen-devel] [patch 07/20] XEN-paravirt: paravirt shared
	kernel pmd flag
References: <20070113014539.408244126@goop.org>
 <20070113014647.796412179@goop.org>
In-Reply-To: <20070113014647.796412179@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Jeremy Fitzhardinge <jeremy@goop.org> 13.01.07 02:45 >>>
>Xen does not allow guests to have the kernel pmd shared between page
>tables, so parameterize pgtable.c to allow both modes of operation.

I don't think the change to vmalloc_sync_all in this patch is necessary -
the mechanism exists solely for dealing with modular users of the die
notifier in the NMI case. Since there's no NMI visible to guests, I don't
think the mechanism is necessary; it could even be completely
circumvented for paravirtual guests.

Jan
