Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWHAJCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWHAJCT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWHAJCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:02:19 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:43136 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751271AbWHAJCS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:02:18 -0400
Date: Tue, 1 Aug 2006 02:03:30 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Christoph Lameter <clameter@sgi.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Gerd Hoffmann <kraxel@suse.de>, Hollis Blanchard <hollisb@us.ibm.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 7 of 13] Make __FIXADDR_TOP variable to allow it to make space for a hypervisor
Message-ID: <20060801090330.GC2654@sequoia.sous-sol.org>
References: <patchbomb.1154421371@ezr.goop.org> <b6c100bb5ca5e2839ac8.1154421378@ezr.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6c100bb5ca5e2839ac8.1154421378@ezr.goop.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeremy Fitzhardinge (jeremy@xensource.com) wrote:
> -#define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
> +#define MAXMEM			(__FIXADDR_TOP-__PAGE_OFFSET-__VMALLOC_RESERVE)

In the native case we lose one page of lowmem now.

thanks,
-chris
