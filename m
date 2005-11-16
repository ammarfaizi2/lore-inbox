Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbVKPIQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbVKPIQd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbVKPIQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:16:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:954 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030221AbVKPIQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:16:32 -0500
Date: Wed, 16 Nov 2005 08:16:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Simon.Derr@bull.net, steiner@sgi.com
Subject: Re: [PATCH] cpuset export symbols gpl
Message-ID: <20051116081627.GA20555@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Simon.Derr@bull.net, steiner@sgi.com
References: <20051116012254.6470.89326.sendpatchset@jackhammer.engr.sgi.com> <20051115173935.5fc75e00.akpm@osdl.org> <20051115180336.11139847.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115180336.11139847.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 06:03:36PM -0800, Paul Jackson wrote:
> Andrew wrote (of exporting cpuset symbols)
> > We normally would do this when such modules are merged.  Do tell us more..
> 
> It was an oversight not to do this when cpusets went in last year,
> but we didn't notice, as the loadable module we cared about had a
> hack in place from earlier development that avoided needing this.
> 
> In cleaning this up, we realized that the module needed to access
> task->cpuset->cpus_allowed, and that the correct (and safe) way to
> do this, via cpuset_cpus_allowed(), was not available to the module.
> 
> The other 4 exports I added on general principles, but don't have
> any pressing need for.  The one I need is cpuset_cpus_allowed().
> 
> The loadable module in question we call 'dplace', and is used to
> provide fancier cpuset-relative task placement by manipulating
> task->cpus_allowed at exec.

Again, where is the module.  Please submit the change to export the
symbols in the same patch series as that module.  And honestly I don't
think it'll survive review when it's poking that deeply into cpuset
internals, but we'll see how to do it properly once it's sent here.

