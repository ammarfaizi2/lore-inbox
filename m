Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVGSRT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVGSRT7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 13:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVGSRT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 13:19:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38582 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261562AbVGSRT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 13:19:59 -0400
From: Daniel Phillips <phillips@redhat.com>
Organization: Red Hat
To: linux-cluster@redhat.com
Subject: Re: [Linux-cluster] [RFC] nodemanager, ocfs2, dlm
Date: Wed, 20 Jul 2005 03:19:50 +1000
User-Agent: KMail/1.7.2
Cc: David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com
References: <20050718061553.GA9568@redhat.com>
In-Reply-To: <20050718061553.GA9568@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507200319.51000.phillips@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 July 2005 16:15, David Teigland wrote:
> I've taken a stab at generalizing ocfs2_nodemanager so the dlm could use
> it (removing ocfs-specific stuff).  It still needs some work, but I'd
> like to know if this appeals to the ocfs group and to others who were
> interested in seeing some similarity in dlm/ocfs configuration.

Let me get this straight.  The proposal is to expose cluster membership as a 
virtual filesystem and use that as the primary membership interface?  So 
that, e.g., a server on the cluster does a getdents to find out what nodes 
are in the cluster or uses inotify to learn about membership changes, 
instead of subscribing for and receiving membership events directly from 
the cluster membership manager?

Or what is this about, just providing a nice friendly view of the cluster to 
the administrator, not intended to be used by cluster infrastructure 
components?

Regards,

Daniel
