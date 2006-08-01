Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWHAOes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWHAOes (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWHAOer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:34:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36821 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932075AbWHAOeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:34:44 -0400
Date: Tue, 1 Aug 2006 07:34:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: jeremy@xensource.com, linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       Christian.Limpach@cl.cam.ac.uk, clameter@sgi.com, ebiederm@xmission.com,
       kraxel@suse.de, hollisb@us.ibm.com, ian.pratt@xensource.com,
       rusty@rustcorp.com.au, zach@vmware.com
Subject: Re: [PATCH 7 of 13] Make __FIXADDR_TOP variable to allow it to make
 space for a hypervisor
Message-Id: <20060801073428.f543ba9f.akpm@osdl.org>
In-Reply-To: <20060801090330.GC2654@sequoia.sous-sol.org>
References: <patchbomb.1154421371@ezr.goop.org>
	<b6c100bb5ca5e2839ac8.1154421378@ezr.goop.org>
	<20060801090330.GC2654@sequoia.sous-sol.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006 02:03:30 -0700
Chris Wright <chrisw@sous-sol.org> wrote:

> * Jeremy Fitzhardinge (jeremy@xensource.com) wrote:
> > -#define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
> > +#define MAXMEM			(__FIXADDR_TOP-__PAGE_OFFSET-__VMALLOC_RESERVE)
> 
> In the native case we lose one page of lowmem now.

erm, isn't this the hunk which gave one of my machines a 4kb highmem zone?
I have memories of reverting it.
