Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbWFNOrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWFNOrG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWFNOrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:47:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33975 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964988AbWFNOrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:47:04 -0400
Date: Wed, 14 Jun 2006 10:46:25 -0400
From: Alexander Viro <aviro@redhat.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       John T Kohl <jtk@us.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jes Sorensen <jes@sgi.com>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       linux-audit@redhat.com, Alan Stern <stern@rowland.harvard.edu>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 06/11] Task watchers:  Register audit task watcher
Message-ID: <20060614144625.GB18305@devserv.devel.redhat.com>
References: <20060613235122.130021000@localhost.localdomain> <1150242886.21787.146.camel@stark>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150242886.21787.146.camel@stark>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2006 at 04:54:46PM -0700, Matt Helsley wrote:
> Adapt audit to use task watchers.

audit_free(p) really expects that either p is a stillborn (never ran)
*or* that p == current.
