Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262525AbSIPQOs>; Mon, 16 Sep 2002 12:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262532AbSIPQOs>; Mon, 16 Sep 2002 12:14:48 -0400
Received: from [195.223.140.120] ([195.223.140.120]:28280 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262525AbSIPQOr>; Mon, 16 Sep 2002 12:14:47 -0400
Date: Mon, 16 Sep 2002 18:20:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Samuel Flory <sflory@rackable.com>, Stephen Lord <lord@sgi.com>,
       Austin Gonyou <austin@coremetrics.com>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: 2.4.20pre5aa2
Message-ID: <20020916162001.GK11605@dualathlon.random>
References: <20020911201602.A13655@pc9391.uni-regensburg.de> <1031768655.24629.23.camel@UberGeek.coremetrics.com> <20020911184111.GY17868@dualathlon.random> <3D81235B.6080809@rackable.com> <20020913002316.GG11605@dualathlon.random> <1031878070.1236.29.camel@snafu> <20020913005440.GJ11605@dualathlon.random> <3D8149F6.9060702@rackable.com> <20020913125345.GO11605@dualathlon.random> <3D8600DD.1010707@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8600DD.1010707@us.ibm.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2002 at 09:03:41AM -0700, Dave Hansen wrote:
> +	vmi = get_vmalloc_info();

hmm, not sure if it's better to slowdown vmalloc instead of
/proc/meminfo and to keep meminfo o1. In theory vmalloc should be used
only for persistent infrequent allocations, so meminfo has a chance to
be recalled more frequently with monitors like xosview during workloads.
Admittedly in final production with no monitoring meminfo is going to
never be recalled, however I like the idea to keep meminfo very quick.

Andrea
