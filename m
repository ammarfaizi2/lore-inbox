Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272160AbTHIBJX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 21:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272156AbTHIBJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 21:09:07 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:27152
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S272228AbTHIBFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 21:05:48 -0400
Date: Fri, 8 Aug 2003 18:05:44 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, dan@debian.org,
       linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: ext3 badness in 2.6.0-test2
Message-ID: <20030809010544.GC1027@matchmail.com>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	Andrew Morton <akpm@osdl.org>, dan@debian.org,
	linux-kernel@vger.kernel.org, ext3-users@redhat.com
References: <20030804142245.GA1627@nevyn.them.org> <20030804132219.2e0c53b4.akpm@osdl.org> <16176.41431.279477.273718@gargle.gargle.HOWL> <20030805235735.4c180fa4.akpm@osdl.org> <16178.63046.43567.551323@gargle.gargle.HOWL> <20030807181631.2962dfca.akpm@osdl.org> <16180.17103.360112.493943@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16180.17103.360112.493943@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 10:39:43AM +1000, Neil Brown wrote:
> -		sh = get_active_stripe(conf, new_sector, pd_idx, (bi->bi_rw&RWA_MASK));
> +		sh = get_active_stripe(conf, new_sector, pd_idx, 0/*(bi->bi_rw&RWA_MASK)*/);

Wouldn't it be better to remove instead of just commenting out that part?

At first glance it looked like a device by zero error... :-/
