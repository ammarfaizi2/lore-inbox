Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269629AbUJWAhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269629AbUJWAhE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 20:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269620AbUJWAgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:36:22 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:61123 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S269386AbUJWAYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:24:25 -0400
Message-ID: <41799BEE.1030104@drdos.com>
Date: Fri, 22 Oct 2004 17:46:54 -0600
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jonathan@jonmasters.org
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.9 and GPL Buyout
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>	 <417550FB.8020404@drdos.com> <35fb2e590410221714205fe526@mail.gmail.com>
In-Reply-To: <35fb2e590410221714205fe526@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Masters wrote:

>On Tue, 19 Oct 2004 11:38:03 -0600, Jeff V. Merkey <jmerkey@drdos.com> wrote:
>
>  
>
>>The memory sickness with disappearing buffers, and the BIO callback
>>problems with the SCSI layer previously reported appear to be corrected.
>>    
>>
>
>Do you even know anything about the above?
>  
>

Yeah. I reported both in two threads.

>  
>
>>This release is very solid and withstands 400 MB/S I/O to disk from
>>3GB/1GB split kernel/user memory configurations
>>    
>>
>
>Oh good.
>
>  
>
>>stable enough for us to use and ship in our products based on our
>>testing of the 2.6.9 release over two days.
>>    
>>
>
>Wow! That's quality there. Do you model your testing process on SCO
>directly? i.e. can I have you go on record that your testing process
>is satisfied after two days of testing?
>
>  
>

No. It's still running with the following metrics, it's been up all 
week, and it doesn't
crash in 20 minutes, which it always did before, and my BIO multiple 
page requests
don't corrupt memory anymore:

MemTotal:      2983468 kB
MemFree:        140692 kB
Buffers:        218568 kB
Cached:         128308 kB
SwapCached:          0 kB
Active:         169904 kB
Inactive:       191432 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      2983468 kB
LowFree:        140692 kB
SwapTotal:     1052248 kB
SwapFree:      1052248 kB
Dirty:             132 kB
Writeback:           0 kB
Mapped:          18608 kB
Slab:          2472572 kB
Committed_AS:    95480 kB
PageTables:       1060 kB
VmallocTotal:   122804 kB
VmallocUsed:      3248 kB
VmallocChunk:   119088 kB


slabinfo - version: 2.0
# name <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : 
tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> 
<num_slabs> <sharedavail>
bt_sock 3 10 384 10 1 : tunables 54 27 0 : slabdata 1 1 0
ip_fib_alias 11 226 16 226 1 : tunables 120 60 0 : slabdata 1 1 0
ip_fib_hash 11 119 32 119 1 : tunables 120 60 0 : slabdata 1 1 0
scsi_cmd_cache 160 160 384 10 1 : tunables 54 27 0 : slabdata 16 16 0
sgpool-128 32 32 2048 2 1 : tunables 24 12 0 : slabdata 16 16 0
sgpool-64 32 32 1024 4 1 : tunables 54 27 0 : slabdata 8 8 0
sgpool-32 79 136 512 8 1 : tunables 54 27 0 : slabdata 11 17 0
sgpool-16 45 45 256 15 1 : tunables 120 60 0 : slabdata 3 3 0
sgpool-8 217 217 128 31 1 : tunables 120 60 0 : slabdata 7 7 0
dm_tio 0 0 16 226 1 : tunables 120 60 0 : slabdata 0 0 0
dm_io 0 0 16 226 1 : tunables 120 60 0 : slabdata 0 0 0
uhci_urb_priv 0 0 44 88 1 : tunables 120 60 0 : slabdata 0 0 0
dn_fib_info_cache 0 0 128 31 1 : tunables 120 60 0 : slabdata 0 0 0
dn_dst_cache 0 0 256 15 1 : tunables 120 60 0 : slabdata 0 0 0
dn_neigh_cache 0 0 256 15 1 : tunables 120 60 0 : slabdata 0 0 0
decnet_socket_cache 0 0 768 5 1 : tunables 54 27 0 : slabdata 0 0 0
clip_arp_cache 0 0 256 15 1 : tunables 120 60 0 : slabdata 0 0 0
xfrm6_tunnel_spi 0 0 64 61 1 : tunables 120 60 0 : slabdata 0 0 0
fib6_nodes 13 119 32 119 1 : tunables 120 60 0 : slabdata 1 1 0
ip6_dst_cache 51 90 256 15 1 : tunables 120 60 0 : slabdata 6 6 0
ndisc_cache 9 30 256 15 1 : tunables 120 60 0 : slabdata 2 2 0
rawv6_sock 3 6 640 6 1 : tunables 54 27 0 : slabdata 1 1 0
udpv6_sock 0 0 640 6 1 : tunables 54 27 0 : slabdata 0 0 0
tcpv6_sock 2 7 1152 7 2 : tunables 24 12 0 : slabdata 1 1 0
unix_sock 40 40 384 10 1 : tunables 54 27 0 : slabdata 4 4 0
ip_mrt_cache 0 0 128 31 1 : tunables 120 60 0 : slabdata 0 0 0
tcp_tw_bucket 0 0 128 31 1 : tunables 120 60 0 : slabdata 0 0 0
tcp_bind_bucket 1 226 16 226 1 : tunables 120 60 0 : slabdata 1 1 0
tcp_open_request 0 0 128 31 1 : tunables 120 60 0 : slabdata 0 0 0
inet_peer_cache 0 0 64 61 1 : tunables 120 60 0 : slabdata 0 0 0
secpath_cache 0 0 128 31 1 : tunables 120 60 0 : slabdata 0 0 0
xfrm_dst_cache 0 0 256 15 1 : tunables 120 60 0 : slabdata 0 0 0
ip_dst_cache 7 15 256 15 1 : tunables 120 60 0 : slabdata 1 1 0
arp_cache 1 31 128 31 1 : tunables 120 60 0 : slabdata 1 1 0
raw_sock 2 7 512 7 1 : tunables 54 27 0 : slabdata 1 1 0
udp_sock 4 7 512 7 1 : tunables 54 27 0 : slabdata 1 1 0
tcp_sock 0 0 1024 4 1 : tunables 54 27 0 : slabdata 0 0 0
flow_cache 0 0 128 31 1 : tunables 120 60 0 : slabdata 0 0 0
isofs_inode_cache 0 0 320 12 1 : tunables 54 27 0 : slabdata 0 0 0
fat_inode_cache 0 0 340 11 1 : tunables 54 27 0 : slabdata 0 0 0
ext2_inode_cache 0 0 400 10 1 : tunables 54 27 0 : slabdata 0 0 0
journal_handle 37 135 28 135 1 : tunables 120 60 0 : slabdata 1 1 0
journal_head 92 243 48 81 1 : tunables 120 60 0 : slabdata 3 3 0
revoke_table 4 290 12 290 1 : tunables 120 60 0 : slabdata 1 1 0
revoke_record 0 0 16 226 1 : tunables 120 60 0 : slabdata 0 0 0
ext3_inode_cache 389931 397737 440 9 1 : tunables 54 27 0 : slabdata 
44193 44193 0
ext3_xattr 0 0 44 88 1 : tunables 120 60 0 : slabdata 0 0 0
reiser_inode_cache 0 0 368 11 1 : tunables 54 27 0 : slabdata 0 0 0
dquot 0 0 128 31 1 : tunables 120 60 0 : slabdata 0 0 0
eventpoll_pwq 0 0 36 107 1 : tunables 120 60 0 : slabdata 0 0 0
eventpoll_epi 0 0 128 31 1 : tunables 120 60 0 : slabdata 0 0 0
kioctx 0 0 256 15 1 : tunables 120 60 0 : slabdata 0 0 0
kiocb 0 0 128 31 1 : tunables 120 60 0 : slabdata 0 0 0
dnotify_cache 0 0 20 185 1 : tunables 120 60 0 : slabdata 0 0 0
fasync_cache 0 0 16 226 1 : tunables 120 60 0 : slabdata 0 0 0
shmem_inode_cache 4 10 384 10 1 : tunables 54 27 0 : slabdata 1 1 0
posix_timers_cache 0 0 96 41 1 : tunables 120 60 0 : slabdata 0 0 0
uid_cache 1 61 64 61 1 : tunables 120 60 0 : slabdata 1 1 0
cfq_pool 64 119 32 119 1 : tunables 120 60 0 : slabdata 1 1 0
crq_pool 0 0 36 107 1 : tunables 120 60 0 : slabdata 0 0 0
deadline_drq 0 0 48 81 1 : tunables 120 60 0 : slabdata 0 0 0
as_arq 205 390 60 65 1 : tunables 120 60 0 : slabdata 6 6 0
blkdev_ioc 42 185 20 185 1 : tunables 120 60 0 : slabdata 1 1 0
blkdev_queue 21 24 456 8 1 : tunables 54 27 0 : slabdata 3 3 0
blkdev_requests 218 234 152 26 1 : tunables 120 60 0 : slabdata 9 9 0
biovec-(256) 256 256 3072 2 2 : tunables 24 12 0 : slabdata 128 128 0
biovec-128 256 260 1536 5 2 : tunables 24 12 0 : slabdata 52 52 0
biovec-64 256 260 768 5 1 : tunables 54 27 0 : slabdata 52 52 0
biovec-16 131331 131340 256 15 1 : tunables 120 60 0 : slabdata 8756 8756 0
biovec-4 256 305 64 61 1 : tunables 120 60 0 : slabdata 5 5 0
biovec-1 319 452 16 226 1 : tunables 120 60 0 : slabdata 2 2 0
bio 131370 131394 64 61 1 : tunables 120 60 0 : slabdata 2154 2154 0
file_lock_cache 45 45 88 45 1 : tunables 120 60 0 : slabdata 1 1 0
sock_inode_cache 70 70 384 10 1 : tunables 54 27 0 : slabdata 7 7 0
skbuff_head_cache 2076 2115 256 15 1 : tunables 120 60 0 : slabdata 141 
141 0
sock 22 30 384 10 1 : tunables 54 27 0 : slabdata 3 3 0
proc_inode_cache 320 416 308 13 1 : tunables 54 27 0 : slabdata 32 32 0
sigqueue 27 27 148 27 1 : tunables 120 60 0 : slabdata 1 1 0
radix_tree_node 14371 20552 276 14 1 : tunables 54 27 0 : slabdata 1468 
1468 0
bdev_cache 9 14 512 7 1 : tunables 54 27 0 : slabdata 2 2 0
mnt_cache 21 31 128 31 1 : tunables 120 60 0 : slabdata 1 1 0
inode_cache 3465 3484 292 13 1 : tunables 54 27 0 : slabdata 268 268 0
dentry_cache 325624 352016 140 28 1 : tunables 120 60 0 : slabdata 12572 
12572 0
filp 651 735 256 15 1 : tunables 120 60 0 : slabdata 49 49 0
names_cache 4 4 4096 1 1 : tunables 24 12 0 : slabdata 4 4 0
idr_layer_cache 101 116 136 29 1 : tunables 120 60 0 : slabdata 4 4 0
buffer_head 56316 60750 48 81 1 : tunables 120 60 0 : slabdata 750 750 0
mm_struct 73 84 640 6 1 : tunables 54 27 0 : slabdata 14 14 0
vm_area_struct 1508 1645 84 47 1 : tunables 120 60 0 : slabdata 35 35 0
fs_cache 119 119 32 119 1 : tunables 120 60 0 : slabdata 1 1 0
files_cache 77 77 512 7 1 : tunables 54 27 0 : slabdata 11 11 0
signal_cache 124 124 128 31 1 : tunables 120 60 0 : slabdata 4 4 0
sighand_cache 105 105 1408 5 2 : tunables 24 12 0 : slabdata 21 21 0
task_struct 105 105 1376 5 2 : tunables 24 12 0 : slabdata 21 21 0
anon_vma 754 1221 8 407 1 : tunables 120 60 0 : slabdata 3 3 0
pgd 73 73 4096 1 1 : tunables 24 12 0 : slabdata 73 73 0
size-131072(DMA) 0 0 131072 1 32 : tunables 8 4 0 : slabdata 0 0 0
size-131072 1 1 131072 1 32 : tunables 8 4 0 : slabdata 1 1 0
size-65536(DMA) 0 0 65536 1 16 : tunables 8 4 0 : slabdata 0 0 0
size-65536 32950 32950 65536 1 16 : tunables 8 4 0 : slabdata 32950 32950 0
size-32768(DMA) 0 0 32768 1 8 : tunables 8 4 0 : slabdata 0 0 0
size-32768 7 7 32768 1 8 : tunables 8 4 0 : slabdata 7 7 0
size-16384(DMA) 0 0 16384 1 4 : tunables 8 4 0 : slabdata 0 0 0
size-16384 35 35 16384 1 4 : tunables 8 4 0 : slabdata 35 35 0
size-8192(DMA) 0 0 8192 1 2 : tunables 8 4 0 : slabdata 0 0 0
size-8192 107 107 8192 1 2 : tunables 8 4 0 : slabdata 107 107 0
size-4096(DMA) 0 0 4096 1 1 : tunables 24 12 0 : slabdata 0 0 0
size-4096 2101 2101 4096 1 1 : tunables 24 12 0 : slabdata 2101 2101 0
size-2048(DMA) 0 0 2048 2 1 : tunables 24 12 0 : slabdata 0 0 0
size-2048 32964 32964 2048 2 1 : tunables 24 12 0 : slabdata 16482 16482 0
size-1024(DMA) 0 0 1024 4 1 : tunables 54 27 0 : slabdata 0 0 0
size-1024 195 200 1024 4 1 : tunables 54 27 0 : slabdata 50 50 0
size-512(DMA) 0 0 512 8 1 : tunables 54 27 0 : slabdata 0 0 0
size-512 186 560 512 8 1 : tunables 54 27 0 : slabdata 70 70 0
size-256(DMA) 0 0 256 15 1 : tunables 120 60 0 : slabdata 0 0 0
size-256 263 465 256 15 1 : tunables 120 60 0 : slabdata 31 31 0
size-128(DMA) 0 0 128 31 1 : tunables 120 60 0 : slabdata 0 0 0
size-128 2267 2294 128 31 1 : tunables 120 60 0 : slabdata 74 74 0
size-64(DMA) 0 0 64 61 1 : tunables 120 60 0 : slabdata 0 0 0
size-64 4152 4453 64 61 1 : tunables 120 60 0 : slabdata 73 73 0
size-32(DMA) 0 0 32 119 1 : tunables 120 60 0 : slabdata 0 0 0
size-32 53338 53431 32 119 1 : tunables 120 60 0 : slabdata 449 449 0
kmem_cache 124 124 128 31 1 : tunables 120 60 0 : slabdata 4 4 0


>>SCO has contacted us and identifed with precise detail and factual
>>documentation the code and intellectual property in Linux they claim was
>>taken from Unix. We have reviewed their claims and they appear to create enough
>>uncertianty to warrant removal of the infringing portions.
>>    
>>
>
>Will you offer that as an undertaking, properly signed and sealed,
>though? If these unfortunate sections of code are removed, will you
>guarantee SCO won't sue?
>  
>

I have convinced Darl to post a program that will state exactly this. 
When we have completed our
Linux code removal he will allow anyone to do the same and he told us he 
would agree not to sue
and state this to whomever would remove the code and complete this 
process. Seems reasonable.

>
>Jon.
>
>  
>
As far as RCU goes, there's so many three letter acronyms, RCU could 
stand for anything. How
about Read Copy Update for locking primitives.

Jeff

