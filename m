Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVCCNin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVCCNin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 08:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVCCNin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 08:38:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4018 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261606AbVCCNil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 08:38:41 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050302135146.2248c7e5.akpm@osdl.org> 
References: <20050302135146.2248c7e5.akpm@osdl.org>  <20050302090734.5a9895a3.akpm@osdl.org> <9420.1109778627@redhat.com> <31789.1109799287@redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] BDI: Provide backing device capability information 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Thu, 03 Mar 2005 13:38:15 +0000
Message-ID: <13767.1109857095@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> 
> > +#define BDI_CAP_MAP_COPY	0x00000001	/* Copy can be mapped (MAP_PRIVATE) */
> > +#define BDI_CAP_MAP_DIRECT	0x00000002	/* Can be mapped directly (MAP_SHARED) */
> 
> Why not make these bitfields as well?

Because I want to copy the capabilities mask (including these variables) into
a variable in the nommu mmap implementation and eliminate various bits from
that variable under certain conditions.

Making these into bitfields would result in having to use three variables
instead of just the one.

David

