Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbVFUWob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbVFUWob (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVFUWm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:42:29 -0400
Received: from cantor.suse.de ([195.135.220.2]:39886 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262423AbVFUWgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 18:36:22 -0400
Date: Wed, 22 Jun 2005 00:36:16 +0200
From: Andi Kleen <ak@suse.de>
To: YhLu <YhLu@tyan.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 with dual way dual core ck804 MB
Message-ID: <20050621223616.GH14251@wotan.suse.de>
References: <3174569B9743D511922F00A0C94314230A40468C@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C94314230A40468C@TYANWEB>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 02:41:52PM -0700, YhLu wrote:
> andi,
> 
> for the dual way dual core Opteron ck804 MB, the 2.6.12 still has the timing
> problem, I  still need to add one printk in amd_detec_cmp after the
> phys_proc_id is setup.

Can you perhaps do some debugging to find out where it hangs? 

e.g. you could let CPU #1 write into a buffer from source
code tracing statement and then read that in CPU #0 after some time
out. That should not disturb timing.

-Andi

