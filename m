Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbVIAUMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbVIAUMD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbVIAUMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:12:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58588 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030356AbVIAUMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:12:00 -0400
Date: Thu, 1 Sep 2005 13:10:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: greg@kroah.com, shaohua.li@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH]reconfigure MSI registers after resume
Message-Id: <20050901131017.67c66f23.akpm@osdl.org>
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E502409A459F1@orsmsx404.amr.corp.intel.com>
References: <C7AB9DA4D0B1F344BF2489FA165E502409A459F1@orsmsx404.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Nguyen, Tom L" <tom.l.nguyen@intel.com> wrote:
>
> On Thursday, September 01, 2005 12:32 PM Andrew Morton wrote:
> > So what is the alternative to Shaohua's fix?  Restore all the msi 
> > registers on resume?
> 
> Yes, the PCIe port bus driver, for example, did that.
> 

So you're saying that each individual driver which uses MSI is responsible
for the restore?  Is it not possible to do this in some single centralised
place?
