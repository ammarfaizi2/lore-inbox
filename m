Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUEXHWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUEXHWg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264090AbUEXHWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:22:36 -0400
Received: from web90005.mail.scd.yahoo.com ([66.218.94.63]:1132 "HELO
	web90005.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S264085AbUEXHVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:21:15 -0400
Message-ID: <20040524072107.63774.qmail@web90005.mail.scd.yahoo.com>
Date: Mon, 24 May 2004 00:21:07 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: Help understanding slow down
To: Phy Prabab <phyprabab@yahoo.com>,
       William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, jakob@unthought.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040524063959.5107.qmail@web90007.mail.scd.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For more information, I ran the same test on 2.4.21
with profiling enabled:
22133 total               0.0102
18255 default_idle        351.0577
634 do_page_fault         0.4412
342 do_no_page            0.3654
231 d_lookup              0.8134
173 do_anonymous_page     0.2790
157 system_call           2.8036
157 pte_alloc_atomic      0.2973
130 do_wp_page            0.1222
102 __find_get_page       1.5000
99 atomic_dec_and_lock    1.3750
90 handle_mm_fault        0.2616
89 zap_page_range         0.0792
86 link_path_walk         0.0343
62 mraccessf              0.6458
59 permission             0.4470
56 mrunlock               0.5600
42 strncpy_from_user      0.5526
40 strnlen_user           0.4545
40 __do_generic_file_read 0.0316
39 __free_pages           1.2188
35 filemap_nopage         0.0648

Also refomated the previous report to make it
readable:

> 317955 total                 0.1302
> 263633 poll_idle             4545.3966
> 6764 do_page_fault           5.1951
> 3650 kmap_atomic             28.2946
> 3288 __d_lookup              12.0000
> 1856 atomic_dec_and_lock     30.4262
> 1823 do_no_page              2.4870
> 1398 do_anonymous_page       3.1991
> 1168 link_path_walk          0.5266
> 1138 find_get_page           19.9649
                               1.2450
> 1075 nfs_lookup_revalidate   0.7739
> 1039 page_remove_rmap        5.0437
> 1006 in_group_p              9.4906
> 987 handle_mm_fault          2.2742
> 913 do_wp_page               1.1499
> 816 finish_task_switch       6.6885
> 772 tg3_poll                 2.6621
> 762 rpcauth_lookup_credcache 1.3275
> 722 page_add_file_rmap       4.1257
> 623 system_call              14.1591
> 607 strncpy_from_user        6.8202
> 
> Thanks again!
> Phy
> 
> 
> 
> --- William Lee Irwin III <wli@holomorphy.com>
> wrote:
> > On Sun, May 23, 2004 at 11:23:37PM -0700, Phy
> Prabab
> > wrote:
> > > Sorry for the late reply.   No this is a dual
> Xeon
> > > 3.06Ghz.  All runs are with the same hardware
> and
> > same
> > > make/build system.
> > > How do I generate a profile of the system.  I
> have
> > > alrady compiled profiling and have enabled the
> > kernel.
> > 
> > readprofile -n -m /boot/System.map-`uname -r` |
> sort
> > -rn -k 1,1 | head -22
> > 
> > No need for compiled-in support, just boot with
> > profile=1.
> > 
> > 
> > -- wli
> 
> 
> 	
> 		
> __________________________________
> Do you Yahoo!?
> Yahoo! Domains – Claim yours for only $14.70/year
> http://smallbusiness.promotions.yahoo.com/offer 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


	
		
__________________________________
Do you Yahoo!?
Yahoo! Domains – Claim yours for only $14.70/year
http://smallbusiness.promotions.yahoo.com/offer 
