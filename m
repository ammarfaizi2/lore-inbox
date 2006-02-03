Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbWBCSou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWBCSou (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWBCSou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:44:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24541 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030202AbWBCSot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:44:49 -0500
Date: Fri, 3 Feb 2006 10:44:29 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Dave Jones <davej@redhat.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com
Subject: Re: more cfq spinlock badness
Message-Id: <20060203104429.08da60bf.zaitcev@redhat.com>
In-Reply-To: <mailman.1138828082.21892.linux-kernel2news@redhat.com>
References: <20060131063938.GA1876@redhat.com>
	<20060131090944.GU4215@suse.de>
	<20060131173601.GA7204@redhat.com>
	<20060201110228.GS4215@suse.de>
	<mailman.1138828082.21892.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2006 11:15:41 -0500, Dave Jones <davej@redhat.com> wrote:

> >  > > Not seen this break for a while, but I just hit it again in 2.6.16rc1-git4.

>  > The ub fix hasn't been merged yet.
> 
> Really? I thought Pete synced up a whole bunch of ub bits including that already.

I did but the patch sat in Greg's and AKPM's trees for a while, so the
first release which contains the CFQ+ub fix is 2.6.16-rc2.

But in any case if no USB devices were connected, ub cannot be in
the picture. It's true even if they were connected and disconnected.
A queue has to be in use before this happens.

-- Pete
