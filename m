Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162387AbWLAXbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162387AbWLAXbp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162260AbWLAXbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:31:36 -0500
Received: from stinky.trash.net ([213.144.137.162]:56273 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1162345AbWLAXbT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:31:19 -0500
Message-ID: <4570BBFE.8090209@trash.net>
Date: Sat, 02 Dec 2006 00:34:22 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: coreteam@netfilter.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [netfilter-core] [2.6 patch] net/*/nf_conntrack_*.c:possible
 cleanups
References: <20061201210113.GI11084@stusta.de>
In-Reply-To: <20061201210113.GI11084@stusta.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make the following needlessly global functions static:
>   - net/netfilter/nf_conntrack_core.c: nf_conntrack_register_cache()
>   - net/netfilter/nf_conntrack_core.c: nf_conntrack_unregister_cache()
>   - net/netfilter/nf_conntrack_core.c: __nf_conntrack_attach()
>   - net/netfilter/nf_conntrack_core.c: set_hashsize()
>   - net/netfilter/nf_conntrack_proto_sctp.c: nf_conntrack_proto_sctp_init()
>   - net/netfilter/nf_conntrack_proto_sctp.c: nf_conntrack_proto_sctp_fini()
> - make the following needlessly global variables/locks/structs static:
>   - net/ipv6/netfilter/nf_conntrack_reasm.c: nf_ct_frag6_secret_interval
>   - net/ipv6/netfilter/nf_conntrack_reasm.c: nf_ct_frag6_mem
>   - net/netfilter/nf_conntrack_core.c: nf_ct_cache_lock
>   - net/netfilter/nf_conntrack_proto_sctp.c: nf_conntrack_protocol_sctp4
>   - net/netfilter/nf_conntrack_proto_sctp.c: nf_conntrack_protocol_sctp6
> - #if 0 the following unused global functions:
>   - net/ipv6/netfilter/nf_conntrack_reasm.c: nf_ct_frag6_kfree_frags()
>   - net/netfilter/nf_conntrack_core.c: nf_conntrack_tuple_taken()
>   - net/netfilter/nf_conntrack_core.c: nf_ct_invert_tuplepr()
> - remove the following unused or write-only variables:
>   - net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c: nat_module_is_loaded
>   - net/ipv6/netfilter/nf_conntrack_reasm.c: nf_ct_frag6_nqueues
> - remove the following unused hooks:
>   - net/netfilter/nf_conntrack_core.c: nf_conntrack_destroyed()
>   - net/netfilter/nf_conntrack_ftp.c: nf_nat_ftp_hook()
> - remove the following unused EXPORT_SYMBOL's:
>   - nf_ct_iterate_cleanup
>   - nf_ct_protos
>   - nf_ct_l3protos
> 
> Please review which of these changes make sense and which might conflict 
> with pending patches.

Thanks Adrian. We have a large nf_conntrack merge coming up, which
conflicts with this patch and includes new users of some of these
symbols. Please send your patch again once these changes have
been merged.

