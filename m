Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWGJJEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWGJJEJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWGJJEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:04:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8521 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751383AbWGJJEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:04:07 -0400
Date: Mon, 10 Jul 2006 11:06:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Michael Kerrisk <mtk-manpages@gmx.net>
Cc: michael.kerrisk@gmx.net, akpm@osdl.org, linux-kernel@vger.kernel.org,
       vendor-sec@lst.de, lcapitulino@mandriva.com.br
Subject: Re: splice/tee bugs?
Message-ID: <20060710090635.GM4141@suse.de>
References: <20060709111629.GV4188@suse.de> <20060709134703.0aa5bc41@home.brethil> <20060709175744.GZ4188@suse.de> <20060710062551.307040@gmx.net> <20060710064355.GB4141@suse.de> <20060710080917.286970@gmx.net> <20060710082423.GI4141@suse.de> <20060710084017.109310@gmx.net> <20060710084645.GJ4141@suse.de> <20060710085025.109290@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060710085025.109290@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10 2006, Michael Kerrisk wrote:
> > So it's find being stuck, this doesn't look tee/splice related at all.
> > Can you reproduce the same thing just by doing the find . > /dev/null?
> 
> Hmm -- yes, I can.  So you are right, it's unrelated to splice.
> Not sure what's going on...

Hmm duh, the one-in-five-runs should have run a bell (and I should have
read the trace more carefully) - it's the access times being synced to
disk. If you mount with noatime,nodiratime you should get consistent
times across runs.

So nothing unexpected there.

-- 
Jens Axboe

