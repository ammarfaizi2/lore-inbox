Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264508AbUADVbp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 16:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbUADVbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 16:31:45 -0500
Received: from scrat.hensema.net ([62.212.82.150]:45190 "EHLO
	scrat.hensema.net") by vger.kernel.org with ESMTP id S264508AbUADVbe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 16:31:34 -0500
From: Erik Hensema <erik@hensema.net>
Subject: Re: 2.6.0: something is leaking memory
Date: Sun, 4 Jan 2004 21:31:26 +0000 (UTC)
Message-ID: <slrnbvh1hd.jl6.erik@dexter.hensema.net>
References: <slrnbvgohn.1pb.erik@dexter.hensema.net> <Pine.LNX.4.58.0401041257290.2162@home.osdl.org>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.3 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds (torvalds@osdl.org) wrote:
> 
> 
> On Sun, 4 Jan 2004, Erik Hensema wrote:
>> 
>> The leak can be most easily seen in my rrdtool graphs of memory
>> usage: http://dexter.hensema.net/~erik/stats/mem-mon.gif and
>> http://dexter.hensema.net/~erik/stats/mem-year.gif - try to guess
>> when I switched to 2.6.0-test11 ;-)
>> 
>> At Dec 31 I upgraded to 2.6.0-final.
>> 
>> Output from ps aux, /proc/vmstat and /proc/meminfo, are attached.
>> My .config isn't compiled in and I haven't got it at hand
>> currently. If anyone is interested I can post it tomorrow.
> 
> Can you do /proc/slabinfo too?

Sure, this is of course my currently running system, 4 days, 9:53
uptime.

slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
ip_conntrack          66    156    320   12    1 : tunables   54   27    0 : slabdata     13     13      0
ip_fib_hash           30    202     16  202    1 : tunables  120   60    0 : slabdata      1      1      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12    0 : slabdata      4      4      0
rpc_tasks              8     20    192   20    1 : tunables  120   60    0 : slabdata      1      1      0
rpc_inode_cache        0      0    384   10    1 : tunables   54   27    0 : slabdata      0      0      0
fib6_nodes            42    112     32  112    1 : tunables  120   60    0 : slabdata      1      1      0
ip6_dst_cache         38     60    256   15    1 : tunables  120   60    0 : slabdata      4      4      0
ndisc_cache           10     20    192   20    1 : tunables  120   60    0 : slabdata      1      1      0
raw6_sock              0      0    640    6    1 : tunables   54   27    0 : slabdata      0      0      0
udp6_sock              2      6    640    6    1 : tunables   54   27    0 : slabdata      1      1      0
tcp6_sock          19729  19732   1024    4    1 : tunables   54   27    0 : slabdata   4933   4933      0
unix_sock             42     50    384   10    1 : tunables   54   27    0 : slabdata      5      5      0
tcp_tw_bucket          5     30    128   30    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_bind_bucket      107    202     16  202    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_open_request       0      0    128   30    1 : tunables  120   60    0 : slabdata      0      0      0
inet_peer_cache       10     59     64   59    1 : tunables  120   60    0 : slabdata      1      1      0
secpath_cache          0      0    128   30    1 : tunables  120   60    0 : slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
ip_dst_cache         259    300    256   15    1 : tunables  120   60    0 : slabdata     20     20      0
arp_cache              4     30    128   30    1 : tunables  120   60    0 : slabdata      1      1      0
raw4_sock              0      0    512    7    1 : tunables   54   27    0 : slabdata      0      0      0
udp_sock              14     14    512    7    1 : tunables   54   27    0 : slabdata      2      2      0
tcp_sock              35     36    896    4    1 : tunables   54   27    0 : slabdata      9      9      0
flow_cache             0      0    128   30    1 : tunables  120   60    0 : slabdata      0      0      0
dm_io                784   1010     16  202    1 : tunables  120   60    0 : slabdata      5      5      0
reiser_inode_cache   3090  11050    384   10    1 : tunables   54   27    0 : slabdata   1105   1105      0
nfs_write_data        36     36    448    9    1 : tunables   54   27    0 : slabdata      4      4      0
nfs_read_data         32     36    448    9    1 : tunables   54   27    0 : slabdata      4      4      0
nfs_inode_cache        0      0    640    6    1 : tunables   54   27    0 : slabdata      0      0      0
nfs_page               0      0    128   30    1 : tunables  120   60    0 : slabdata      0      0      0
ext2_inode_cache       1      9    448    9    1 : tunables   54   27    0 : slabdata      1      1      0
eventpoll_pwq          0      0     36  101    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0    128   30    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
dnotify_cache          0      0     20  169    1 : tunables  120   60    0 : slabdata      0      0      0
file_lock_cache        9     42     92   42    1 : tunables  120   60    0 : slabdata      1      1      0
fasync_cache           0      0     16  202    1 : tunables  120   60    0 : slabdata      0      0      0
shmem_inode_cache      8      9    448    9    1 : tunables   54   27    0 : slabdata      1      1      0
idr_layer_cache        0      0    136   28    1 : tunables  120   60    0 : slabdata      0      0      0
posix_timers_cache      0      0     80   48    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache             10    112     32  112    1 : tunables  120   60    0 : slabdata      1      1      0
deadline_drq           0      0     52   72    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq                21    118     64   59    1 : tunables  120   60    0 : slabdata      2      2      0
blkdev_requests       21     72    160   24    1 : tunables  120   60    0 : slabdata      3      3      0
biovec-BIO_MAX_PAGES    256    260   3072    5    4 : tunables   24   12    0 : slabdata     52     52      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : slabdata     52     52      0
biovec-16            256    260    192   20    1 : tunables  120   60    0 : slabdata     13     13      0
biovec-4             258    295     64   59    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1             300    606     16  202    1 : tunables  120   60    0 : slabdata      3      3      0
bio                  273    413     64   59    1 : tunables  120   60    0 : slabdata      7      7      0
sock_inode_cache     208    230    384   10    1 : tunables   54   27    0 : slabdata     23     23      0
skbuff_head_cache    300    360    192   20    1 : tunables  120   60    0 : slabdata     18     18      0
sock                   7     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
proc_inode_cache     980    980    384   10    1 : tunables   54   27    0 : slabdata     98     98      0
sigqueue              16     27    144   27    1 : tunables  120   60    0 : slabdata      1      1      0
radix_tree_node     2680   2925    260   15    1 : tunables   54   27    0 : slabdata    195    195      0
bdev_cache             9      9    448    9    1 : tunables   54   27    0 : slabdata      1      1      0
mnt_cache             17     59     64   59    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache          917    930    384   10    1 : tunables   54   27    0 : slabdata     93     93      0
dentry_cache        7348  20240    192   20    1 : tunables  120   60    0 : slabdata   1012   1012      0
filp                1048   1290    128   30    1 : tunables  120   60    0 : slabdata     43     43      0
names_cache            6      6   4096    1    1 : tunables   24   12    0 : slabdata      6      6      0
buffer_head        28856  35064     52   72    1 : tunables  120   60    0 : slabdata    487    487      0
mm_struct             58     70    512    7    1 : tunables   54   27    0 : slabdata     10     10      0
vm_area_struct      2337   2832     64   59    1 : tunables  120   60    0 : slabdata     48     48      0
fs_cache              66    112     32  112    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache           58     72    448    9    1 : tunables   54   27    0 : slabdata      8      8      0
signal_cache         124    177     64   59    1 : tunables  120   60    0 : slabdata      3      3      0
sighand_cache         73     81   1344    3    1 : tunables   24   12    0 : slabdata     27     27      0
task_struct          129    140   1568    5    2 : tunables   24   12    0 : slabdata     28     28      0
pte_chain           9102  10679     64   59    1 : tunables  120   60    0 : slabdata    181    181      0
pgd                   58     58   4096    1    1 : tunables   24   12    0 : slabdata     58     58      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192            131    131   8192    1    2 : tunables    8    4    0 : slabdata    131    131      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096            120    120   4096    1    1 : tunables   24   12    0 : slabdata    120    120      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048            160    174   2048    2    1 : tunables   24   12    0 : slabdata     87     87      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024            109    128   1024    4    1 : tunables   54   27    0 : slabdata     32     32      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             288    288    512    8    1 : tunables   54   27    0 : slabdata     36     36      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             394    660    256   15    1 : tunables  120   60    0 : slabdata     44     44      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
size-192              32     40    192   20    1 : tunables  120   60    0 : slabdata      2      2      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60    0 : slabdata      0      0      0
size-128            2675   2730    128   30    1 : tunables  120   60    0 : slabdata     91     91      0
size-64(DMA)           0      0     64   59    1 : tunables  120   60    0 : slabdata      0      0      0
size-64             5724   5782     64   59    1 : tunables  120   60    0 : slabdata     98     98      0
size-32(DMA)           0      0     32  112    1 : tunables  120   60    0 : slabdata      0      0      0
size-32              820    896     32  112    1 : tunables  120   60    0 : slabdata      8      8      0
kmem_cache           132    132    116   33    1 : tunables  120   60    0 : slabdata      4      4      0

> Clearly the memory leak isn't in the page cache, so the most likely source 
> is network buffers, and most likely in iptables connection tracking or 
> similar. If you actually _use_ IPv6, then that is also more likely to have 
> leaks just due to less testing.

I do use IPv6. I've got three active tunnels and native IPv6 over
ethernet.

I've always had problems with nscd leaking filedescriptors, all
IPv6 connections to my LDAP server. This started after upgrading
suse 8.0 to 8.2 (I think the problem is in nss_ldap).
I'm restarting nscd using a cronjob every night now. Output of
netstat --inet6 -avpn is below. All sockets in CLOSE_WAIT are
leaked and will go away after a nscd restart.

> David & co fixed a number of leaks just before 2.6.0-final, but that 
> doesn't mean that they are all gone - rather it means that there 
> definitely were still leaks around just a few weeks ago.

The server isn't very critical, but I do need it. I'm willing to
try some patches (or do an upgrade to -mm), but nothing to wild.

netstat --inet6 -avpn

Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name   
tcp        0      0 :::22                   :::*                    LISTEN      1208/sshd           
tcp        0      0 :::119                  :::*                    LISTEN      1364/innd           
tcp        0      0 :::25                   :::*                    LISTEN      1433/sendmail: acce 
tcp        0      0 :::953                  :::*                    LISTEN      1175/named          
tcp        0      0 ::1:6010                :::*                    LISTEN      19900/sshd          
tcp        0      0 ::1:6011                :::*                    LISTEN      20150/sshd          
tcp        1      0 ::1:50565               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:50224               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        0      0 2001:888:10a1::1:389    ::1:55936               ESTABLISHED 1145/slapd          
tcp        1      0 ::1:50343               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:50988               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:51181               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:51187               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:51186               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:50768               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:50774               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:50772               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:50788               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:50816               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:49454               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:49460               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:49458               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:49470               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:49619               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:49645               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:49644               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:49643               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:49592               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:32776               2001:888:10a1::1:389    CLOSE_WAIT  1510/httpd          
tcp        1      0 ::1:32806               2001:888:10a1::1:389    CLOSE_WAIT  1777/SCREEN         
tcp        0      0 192.168.1.1:119         192.168.1.1:56197       ESTABLISHED 20135/- nnrpd: dext 
tcp        1      0 ::1:32862               2001:888:10a1::1:389    CLOSE_WAIT  2726/httpd          
tcp        1      0 ::1:49291               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        0      0 2001:888:10a1::1:389    ::1:55527               ESTABLISHED 1145/slapd          
tcp        0      0 212.120.97.185:119      62.212.82.150:58902     ESTABLISHED 1364/innd           
tcp        1      0 ::1:52711               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:52263               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        0      0 2001:888:10a1::1:389    ::1:56203               ESTABLISHED 1145/slapd          
tcp        1      0 ::1:52823               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:52839               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:52876               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:52888               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:51563               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:51460               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:51201               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:51420               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:51423               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:51417               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        0      0 2001:888:10a1::1:389    ::1:56204               ESTABLISHED 1145/slapd          
tcp        1      0 ::1:52182               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        0      0 2001:888:10a1::1:389    ::1:56207               ESTABLISHED 1145/slapd          
tcp        0      0 2001:888:10a1::1:389    ::1:56206               ESTABLISHED 1145/slapd          
tcp        1      0 ::1:54612               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:54628               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:54366               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:54389               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:54370               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:54372               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        0      0 2001:888:10a1::1:389    ::1:56179               ESTABLISHED 1145/slapd          
tcp        1      0 ::1:47004               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:47069               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        0     48 212.120.97.185:22       213.84.242.133:55760    ESTABLISHED 20146/sshd          
tcp        1      0 ::1:53575               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:53571               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:53577               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:53722               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:53661               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:53695               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:53347               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:53447               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:54103               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:54087               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:54088               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:54127               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:54047               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        0      0 212.120.97.185:22       213.84.242.133:55733    ESTABLISHED 19807/sshd          
tcp        1      0 ::1:53828               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:53867               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:53809               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:53974               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:53948               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:48465               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:48619               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:48233               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:48381               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:48658               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        1      0 ::1:48878               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        0      0 2001:888:10a1::1:389    ::1:56250               ESTABLISHED 1145/slapd          
tcp        1      0 ::1:47368               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        0      0 2001:888:10a1::1:389    ::1:56188               ESTABLISHED 1145/slapd          
tcp        0      0 ::1:55527               2001:888:10a1::1:389    ESTABLISHED 26536/nscd          
tcp        0      0 212.120.97.185:119      131.211.28.48:47677     ESTABLISHED 1364/innd           
tcp        0      0 ::1:56190               2001:888:10a1::1:389    ESTABLISHED 19900/sshd          
tcp        0      0 ::1:56188               2001:888:10a1::1:389    ESTABLISHED 19807/sshd          
tcp        0      0 ::1:56179               2001:888:10a1::1:389    ESTABLISHED 19807/sshd          
tcp        0      0 ::1:56207               2001:888:10a1::1:389    ESTABLISHED 26536/nscd          
tcp        0      0 ::1:56206               2001:888:10a1::1:389    ESTABLISHED 20150/sshd          
tcp        0      0 ::1:56204               2001:888:10a1::1:389    ESTABLISHED 20146/sshd          
tcp        0      0 ::1:56203               2001:888:10a1::1:389    ESTABLISHED 20146/sshd          
tcp        0      0 ::1:56250               2001:888:10a1::1:389    ESTABLISHED 20670/su            
tcp        0      0 ::1:56249               2001:888:10a1::1:389    TIME_WAIT   -                   
tcp        0      0 ::1:56248               2001:888:10a1::1:389    TIME_WAIT   -                   
tcp        0      0 2001:888:10a1::1:389    ::1:56190               ESTABLISHED 1145/slapd          
tcp        1      0 ::1:47765               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
tcp        0      0 ::1:55936               2001:888:10a1::1:389    ESTABLISHED 26536/nscd          
udp        0      0 :::514                  :::*                                688/syslogd         
udp        0      0 :::32772                :::*                                1175/named          
udp        0      0 :::53                   :::*                                1175/named          
raw        0      0 :::58                   :::*                    7           916/zebra           
-- 
Erik Hensema <erik@hensema.net>
