Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751945AbWCBIrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbWCBIrp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 03:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbWCBIrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 03:47:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64646 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751945AbWCBIro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 03:47:44 -0500
Date: Thu, 2 Mar 2006 08:47:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com
Subject: Re: [PATCH] Proc: move proc fs hooks from cpuset.c to proc/fs/base.c
Message-ID: <20060302084739.GC21902@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Jackson <pj@sgi.com>, akpm@osdl.org, Simon.Derr@bull.net,
	linux-kernel@vger.kernel.org, ebiederm@xmission.com
References: <20060302070812.15674.50176.sendpatchset@jackhammer.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060302070812.15674.50176.sendpatchset@jackhammer.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 11:08:12PM -0800, Paul Jackson wrote:
> From: Paul Jackson <pj@sgi.com>
> 
> Move the generic proc file operations support for
> /proc/<pid>/cpuset from kernel/cpuset.c to fs/proc/base.c.
> 
> Leave behind in kernel/cpuset.c, now as an exported function, the
> cpuset specific support for this /proc/<pid>/cpuset file, which
> writes the cpuset pathname of a tasks cpuset into a seq_file.
> 
> The motivation for this move is to put proc stuff in fs/proc,
> while keeping cpuset stuff in kernel/cpuset.c.

Seems pointless.  This just increases #ifdef churn for no gain.

