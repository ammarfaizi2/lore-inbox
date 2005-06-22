Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbVFVXSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbVFVXSe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 19:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVFVXRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 19:17:54 -0400
Received: from cantor.suse.de ([195.135.220.2]:17832 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262590AbVFVXKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 19:10:55 -0400
Date: Thu, 23 Jun 2005 01:10:54 +0200
From: Andi Kleen <ak@suse.de>
To: Peter Buckingham <peter@pantasys.com>
Cc: Andi Kleen <ak@suse.de>, YhLu <YhLu@tyan.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 with dual way dual core ck804 MB
Message-ID: <20050622231053.GB14251@wotan.suse.de>
References: <3174569B9743D511922F00A0C94314230A40468C@TYANWEB> <20050621221218.GE14251@wotan.suse.de> <42B9E582.80408@pantasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B9E582.80408@pantasys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 03:26:10PM -0700, Peter Buckingham wrote:
> Andi Kleen wrote:
> >On Tue, Jun 21, 2005 at 02:41:52PM -0700, YhLu wrote:
> >It works for me on several dual core systems, except on a very big
> >one that seems to run into a scheduler problem.
> 
> I'm having similar problems with a 16P x86_64. If I boot it with 
> maxcpus=8 I have no problems. Is there some info that might be useful to 
> help debug this problem?

There are two problems on AMD >8P. First the APIC addressing doesn't
work and needs to be done differently (I have a patch for that
in the final stages of testing). And then there is a mysterious
scheduler deadlock problem in 2.6.12 that I haven't tracked down yet. 
2.6.11+patch works though.

-Andi
