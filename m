Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262281AbSJOBzQ>; Mon, 14 Oct 2002 21:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262283AbSJOBzQ>; Mon, 14 Oct 2002 21:55:16 -0400
Received: from holomorphy.com ([66.224.33.161]:20627 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262281AbSJOBzQ>;
	Mon, 14 Oct 2002 21:55:16 -0400
Date: Mon, 14 Oct 2002 18:57:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, john stultz <johnstul@us.ibm.com>,
       Matt <colpatch@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       LSE Tech <lse-tech@lists.sourceforge.net>,
       Andrew Morton <akpm@zip.com.au>, Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] Re: [rfc][patch] Memory Binding API v0.3 2.5.41
Message-ID: <20021015015725.GP4488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	john stultz <johnstul@us.ibm.com>, Matt <colpatch@us.ibm.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	LSE Tech <lse-tech@lists.sourceforge.net>,
	Andrew Morton <akpm@zip.com.au>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>
References: <20021015012015.GN4488@holomorphy.com> <2008756258.1034620187@[10.10.2.3]> <20021015014023.GO4488@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015014023.GO4488@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 06:29:49PM -0700, Martin J. Bligh wrote:
>> The only place I see that used in generic code is
>> calculate_zone_totalpages, free_area_init_core, free_area_init_node,
>> none of which seem to do that. But cscope might be borked again, I
>> guess. Must be done in each arch if at all ... which arch did you
>> think did it?

On Mon, Oct 14, 2002 at 06:40:23PM -0700, William Lee Irwin III wrote:
> Not sure, ISTR something about this going on but I don't see any extant
> examples. At any rate, it should be easy to do it by hand, just make
> sure there are struct pages tracking the holes in mem_map and free the
> space in mem_map that would track the holes.

And buddy bitmaps and ->node_valid_addr too. Which stands a good chance
of explaining why it broke, if it ever worked.

Bill
