Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbULQTaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbULQTaH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 14:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbULQT3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 14:29:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41368 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262137AbULQT20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 14:28:26 -0500
Date: Fri, 17 Dec 2004 20:28:13 +0100
From: Jens Axboe <axboe@suse.de>
To: Doug Maxey <dwm@maxeymade.com>
Cc: kronos@kronoz.cjb.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Rashkae <rashkae@tigershaunt.com>
Subject: Re: Cannot mount multi-session DVD with ide-cd, must use ide-scsi
Message-ID: <20041217192813.GK3140@suse.de>
References: <20041217183303.GA9561@dreamland.darkstar.lan> <200412171857.iBHIvQkG012716@falcon30.maxeymade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412171857.iBHIvQkG012716@falcon30.maxeymade.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17 2004, Doug Maxey wrote:
> 
> On Fri, 17 Dec 2004 19:33:03 +0100, Kronos wrote:
> ...
> > 		if (stat) return stat;
> >+	
> >+		toc->last_session_lba = be32_to_cpu(ms_tmp.ent.addr.lba);
> 
> Should that be le32_to_cpu?

Why? It's read data and that is always big-endian.

-- 
Jens Axboe

