Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266779AbTGKUv5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266778AbTGKUvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:51:35 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:33447 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266684AbTGKUuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:50:23 -0400
Date: Fri, 11 Jul 2003 13:53:23 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 910] New: "events/0:page allocation failure" and " slab error in cache_free_debugcheck()" messages
Message-ID: <841190000.1057956803@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=910

           Summary: "events/0:page allocation failure" and " slab error in
                    cache_free_debugcheck()" messages
    Kernel Version: 2.5.75-bk1
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: robbiew@us.ibm.com
                CC: sglass@us.ibm.com


Distribution:SuSE 8.0

Hardware Environment:
 # cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 864.120
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1708.03

 # cat /proc/slabinfo
slabinfo - version: 2.0 (statistics)
# name            <active_objs> <num_objs> <objsize> <objperslab> 
<pagesperslab> : tunables <batchcount> <limit <sharedfactor> : slabdata 
<active_slabs> <num_slabs> <sharedavail> : globalstat <listallocs> <maxobjs> 
<grown> <reaped> <error> <maxfreeable> <freelimit> : cpustat <allochit 
<allocmiss <freehit <freemiss>
rpc_buffers            8      8   4096    1    1 : tunables   24   12    0 : 
slabdata      8      8      0 : globalstat       8      8     8    0    0    
0   25 : cpustat      0      8      0      0
rpc_tasks              8      8   4096    1    1 : tunables   24   12    0 : 
slabdata      8      8      0 : globalstat       8      8     8    0    0    
0   25 : cpustat      0      8      0      0
rpc_inode_cache       18     18   4096    1    1 : tunables   24   12    0 : 
slabdata     18     18      0 : globalstat      18     18    18    0    0    
0   25 : cpustat      0     18      0      0
unix_sock              7      7   4096    1    1 : tunables   24   12    0 : 
slabdata      7      7      0 : globalstat      58     17    51   44    0    
0   25 : cpustat    144     56    193      0
tcp_tw_bucket          0      0    100   39    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat      48     32     2    2    0    
0   71 : cpustat     16      3     19      0
tcp_bind_bucket       13    126     28  126    1 : tunables   32   16    0 : 
slabdata      1      1      0 : globalstat     128     46     1    0    0    0  
158 : cpustat     43      8     38      0
tcp_open_request       0      0     68   56    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat      16     16     1    1    0    
0   88 : cpustat      0      1      1      0
inet_peer_cache        6     72     52   72    1 : tunables   32   16    0 : 
slabdata      1      1      0 : globalstat     160     21     1    0    0    0  
104 : cpustat      0     10      4      0
secpath4_cache         0      0    136   28    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   60 : cpustat      0      0      0      0
xfrm_dst_cache         0      0   4096    1    1 : tunables   24   12    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   25 : cpustat      0      0      0      0
ip_fib_hash            9    126     28  126    1 : tunables   32   16    0 : 
slabdata      1      1      0 : globalstat      16     16     1    0    0    0  
158 : cpustat      8      1      0      0
ip_dst_cache          19     19   4096    1    1 : tunables   24   12    0 : 
slabdata     19     19      0 : globalstat     126     24   120  101    0    
0   25 : cpustat     10    122    113      0
arp_cache              4      4   4096    1    1 : tunables   24   12    0 : 
slabdata      4      4      0 : globalstat      19      5    18   14    0    
0   25 : cpustat      0     19     15      0
raw4_sock              0      0   4096    1    1 : tunables   24   12    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   25 : cpustat      0      0      0      0
udp_sock              12     12   4096    1    1 : tunables   24   12    0 : 
slabdata     12     12      0 : globalstat      26     19    24   12    0    
0   25 : cpustat     56     26     70      0
tcp_sock              17     17   4096    1    1 : tunables   24   12    0 : 
slabdata     17     17      0 : globalstat      38     24    35   18    0    
0   25 : cpustat     83     38    104      0
flow_cache             0      0    104   37    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   69 : cpustat      0      0      0      0
uhci_urb_priv          0      0     72   53    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   85 : cpustat      0      0      0      0
reiser_inode_cache      0      0   4096    1    1 : tunables   24   12    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   25 : cpustat      0      0      0      0
udf_inode_cache        0      0   4096    1    1 : tunables   24   12    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   25 : cpustat      0      0      0      0
nfs_write_data       649    649   4096    1    1 : tunables   24   12    0 : 
slabdata    649    649      0 : globalstat   42951    861 17241  172    0   
25   25 : cpustat 123747  19719 139304   3513
nfs_read_data         95     95   4096    1    1 : tunables   24   12    0 : 
slabdata     95     95      0 : globalstat     929    153   478  317    0   
25   25 : cpustat  29478    524  29842     65
nfs_inode_cache     9415   9415   4096    1    1 : tunables   24   12    0 : 
slabdata   9415   9415      0 : globalstat   30611  12858 26697  120    0   
41   25 : cpustat   9341  27162  25328   1760
nfs_page            1516   1892     88   44    1 : tunables   32   16    0 : 
slabdata     43     43      0 : globalstat  121324   1980   157    2    0    
0   76 : cpustat 261259   7622 259894   7471
isofs_inode_cache      0      0   4096    1    1 : tunables   24   12    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   25 : cpustat      0      0      0      0
fat_inode_cache        0      0   4096    1    1 : tunables   24   12    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   25 : cpustat      0      0      0      0
ext2_inode_cache     319    319   4096    1    1 : tunables   24   12    0 : 
slabdata    319    319      0 : globalstat    1945   1681  1931  313    0   
25   25 : cpustat     81   1934   1591    105
ext2_xattr             0      0     56   67    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   99 : cpustat      0      0      0      0
journal_handle         0      0     40   92    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    0  
124 : cpustat      0      0      0      0
journal_head           0      0     60   63    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   95 : cpustat      0      0      0      0
revoke_table           0      0     24  145    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    0  
177 : cpustat      0      0      0      0
revoke_record          0      0     28  126    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    0  
158 : cpustat      0      0      0      0
ext3_inode_cache       0      0   4096    1    1 : tunables   24   12    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   25 : cpustat      0      0      0      0
ext3_xattr             0      0     56   67    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   99 : cpustat      0      0      0      0
eventpoll_pwq          0      0     48   78    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    0  
110 : cpustat      0      0      0      0
eventpoll_epi          0      0     88   44    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   76 : cpustat      0      0      0      0
kioctx                 0      0   4096    1    1 : tunables   24   12    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   25 : cpustat      0      0      0      0
kiocb                  0      0   4096    1    1 : tunables   24   12    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   25 : cpustat      0      0      0      0
dnotify_cache          0      0     32  113    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    0  
145 : cpustat      0      0      0      0
file_lock_cache        5     36    108   36    1 : tunables   32   16    0 : 
slabdata      1      1      0 : globalstat     112     22     2    1    0    
0   68 : cpustat    733      7    735      0
fasync_cache           0      0     28  126    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    0  
158 : cpustat      0      0      0      0
shmem_inode_cache      1      1   4096    1    1 : tunables   24   12    0 : 
slabdata      1      1      0 : globalstat       1      1     1    0    0    
0   25 : cpustat      0      1      0      0
idr_layer_cache        0      0   4096    1    1 : tunables   24   12    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   25 : cpustat      0      0      0      0
posix_timers_cache      0      0    100   39    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   71 : cpustat      0      0      0      0
uid_cache              2    101     36  101    1 : tunables   32   16    0 : 
slabdata      1      1      0 : globalstat      32     17     1    0    0    0  
133 : cpustat      1      2      1      0
sgpool-MAX_PHYS_SEGMENTS     32     32   4096    1    1 : tunables   24   12    
0 : slabdata     32     32      0 : globalstat      32     32    32    0    
0    0   25 : cpustat      0     32      0      0
sgpool-64             32     32   4096    1    1 : tunables   24   12    0 : 
slabdata     32     32      0 : globalstat      32     32    32    0    0    
0   25 : cpustat      0     32      0      0
sgpool-32             32     32   4096    1    1 : tunables   24   12    0 : 
slabdata     32     32      0 : globalstat      32     32    32    0    0    
0   25 : cpustat      0     32      0      0
sgpool-16             32     32   4096    1    1 : tunables   24   12    0 : 
slabdata     32     32      0 : globalstat      32     32    32    0    0    
0   25 : cpustat      0     32      0      0
sgpool-8              32     56    140   28    1 : tunables   32   16    0 : 
slabdata      2      2      0 : globalstat      44     44     2    0    0    
0   60 : cpustat     29      3      0      0
as_arq                28     53     72   53    1 : tunables   32   16    0 : 
slabdata      1      1      0 : globalstat    8892    350    13    0    0    
0   85 : cpustat 124431    563 124524    458
deadline_drq           0      0     60   63    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   95 : cpustat      0      0      0      0
blkdev_requests       15     15   4096    1    1 : tunables   24   12    0 : 
slabdata     15     15      0 : globalstat    8601    349  2422  471    0   
25   25 : cpustat 122005   2989 124301    681
biovec-BIO_MAX_PAGES    256    256   4096    1    1 : tunables   24   12    0 : 
slabdata    256    256      0 : globalstat     256    256   256    0    0    
0   25 : cpustat      0    256      0      0
biovec-128           256    256   4096    1    1 : tunables   24   12    0 : 
slabdata    256    256      0 : globalstat     256    256   256    0    0    
0   25 : cpustat      0    256      0      0
biovec-64            256    256   4096    1    1 : tunables   24   12    0 : 
slabdata    256    256      0 : globalstat     515    311   477  210    0   
25   25 : cpustat  29927    485  30151      5
biovec-16            257    257   4096    1    1 : tunables   24   12    0 : 
slabdata    257    257      0 : globalstat     385    267   354   97    0    
0   25 : cpustat   1733    368   1845      0
biovec-4             272    315     60   63    1 : tunables   32   16    0 : 
slabdata      5      5      0 : globalstat     988    274     5    0    0    
0   95 : cpustat   1406     62   1212      0
biovec-1             272    290     24  145    1 : tunables   32   16    0 : 
slabdata      2      2      0 : globalstat  165623   2384    41    2    0    1  
177 : cpustat 383630  10380 383487  10267
bio                  272    280     68   56    1 : tunables   32   16    0 : 
slabdata      5      5      0 : globalstat   88622   2400   123    9    0    
1   88 : cpustat 421629   5594 421543   5424
sock_inode_cache      44     44   4096    1    1 : tunables   24   12    0 : 
slabdata     44     44      0 : globalstat      92     53    90   46    0    
0   25 : cpustat    321     92    369      0
skbuff_head_cache     67     67   4096    1    1 : tunables   24   12    0 : 
slabdata     67     67      0 : globalstat   37694    214  1188  543    0   
25   25 : cpustat 1643282   4272 1644399   3088
sock                   2      2   4096    1    1 : tunables   24   12    0 : 
slabdata      2      2      0 : globalstat       4      3     3    1    0    
0   25 : cpustat     25      4     27      0
proc_inode_cache    1732   1732   4096    1    1 : tunables   24   12    0 : 
slabdata   1732   1732      0 : globalstat    2652   1909  2548  552    0   
25   25 : cpustat   2949   2593   3776     34
sigqueue             389    389   4096    1    1 : tunables   24   12    0 : 
slabdata    389    389      0 : globalstat    1924    627  1875  289    0   
25   25 : cpustat   1580   2021   2975    105
radix_tree_node     1674   1674   4096    1    1 : tunables   24   12    0 : 
slabdata   1674   1674      0 : globalstat   29673   6199 16538  165    0   
25   25 : cpustat  63408  17785  77196   2323
bdev_cache             4     40     96   40    1 : tunables   32   16    0 : 
slabdata      1      1      0 : globalstat      16     16     1    0    0    
0   72 : cpustat      8      1      5      0
mnt_cache             28     53     72   53    1 : tunables   32   16    0 : 
slabdata      1      1      0 : globalstat      80     31     1    0    0    
0   85 : cpustat     27      5      4      0
inode_cache          842    842   4096    1    1 : tunables   24   12    0 : 
slabdata    842    842      0 : globalstat     887    851   883   41    0    
0   25 : cpustat    915    886    959      0
dentry_cache       12486  12486   4096    1    1 : tunables   24   12    0 : 
slabdata  12486  12486      0 : globalstat   35229  15089 30711  511    0   
31   25 : cpustat  44212  31326  61203   1849
filp                2217   2217   4096    1    1 : tunables   24   12    0 : 
slabdata   2217   2217      0 : globalstat   28227  12439 27856  668    0   
38   25 : cpustat  64214  27976  87864   2109
names_cache          498    498   4096    1    1 : tunables   24   12    0 : 
slabdata    498    498      0 : globalstat    7793   1016  3909  317    0   
26   25 : cpustat 260007   4494 263435    569
buffer_head          216    567     60   63    1 : tunables   32   16    0 : 
slabdata      9      9      0 : globalstat  212379  54338  2059    0    0    
1   95 : cpustat 227472  13617 227643  13230
mm_struct            414    414   4096    1    1 : tunables   24   12    0 : 
slabdata    414    414      0 : globalstat    1974    653  1945  228    0   
25   25 : cpustat   2738   1949   4163    111
vm_area_struct      4871   7250     76   50    1 : tunables   32   16    0 : 
slabdata    145    145      0 : globalstat   37846   7582   439    6    0    
1   82 : cpustat  82811   2744  78713   1991
fs_cache             431    702     48   78    1 : tunables   32   16    0 : 
slabdata      9      9      0 : globalstat    2240    667    16    0    0    0  
110 : cpustat   3297    143   2942     82
files_cache          412    412   4096    1    1 : tunables   24   12    0 : 
slabdata    412    412      0 : globalstat    1942    651  1915  201    0   
25   25 : cpustat   1518   1918   2913    111
signal_cache         449    670     56   67    1 : tunables   32   16    0 : 
slabdata     10     10      0 : globalstat    2256    686    20    2    0    
1   99 : cpustat   3321    158   2963     82
sighand_cache        422    422   4096    1    1 : tunables   24   12    0 : 
slabdata    422    422      0 : globalstat    1952    661  1925  200    0   
25   25 : cpustat   1512   1928   2907    111
task_struct          435    435   4084    1    1 : tunables   24   12    0 : 
slabdata    435    435      0 : globalstat    1967    673  1940  203    0   
25   25 : cpustat   1536   1943   2933    111
pte_chain           6992  10509     32  113    1 : tunables   32   16    0 : 
slabdata     93     93      0 : globalstat   54759  12171   235    2    0    1  
145 : cpustat  75656   3633  69384   2925
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0    9 : cpustat      0      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0    9 : cpustat      0      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0    9 : cpustat      0      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0    9 : cpustat      0      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0    9 : cpustat      0      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : 
slabdata      0      0      0 : globalstat       1      1     1    1    0    
0    9 : cpustat      0      1      1      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0    9 : cpustat      0      0      0      0
size-16384             0      0  16384    1    4 : tunables    8    4    0 : 
slabdata      0      0      0 : globalstat      34      9    30   30    0    
4    9 : cpustat   3703     31   3732      2
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0    9 : cpustat      0      0      0      0
size-8192              2      2   8192    1    2 : tunables    8    4    0 : 
slabdata      2      2      0 : globalstat      49      6    37   35    0    
0    9 : cpustat    809     44    851      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   25 : cpustat      0      0      0      0
size-4096            153    153   4096    1    1 : tunables   24   12    0 : 
slabdata    153    153      0 : globalstat    2213    153   582   59    0   
25   25 : cpustat 458124    730 458533    168
size-2048(DMA)         0      0   4096    1    1 : tunables   24   12    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   25 : cpustat      0      0      0      0
size-2048             77     77   4096    1    1 : tunables   24   12    0 : 
slabdata     77     77      0 : globalstat   40512    222  1283  625    0   
25   25 : cpustat 1274333   4618 1275567   3309
size-1024(DMA)         0      0   4096    1    1 : tunables   24   12    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   25 : cpustat      0      0      0      0
size-1024             39     39   4096    1    1 : tunables   24   12    0 : 
slabdata     39     39      0 : globalstat     386    182   368  138    0   
25   25 : cpustat  14727    371  15041     18
size-512(DMA)          0      0   4096    1    1 : tunables   24   12    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   25 : cpustat      0      0      0      0
size-512             170    170   4096    1    1 : tunables   24   12    0 : 
slabdata    170    170      0 : globalstat     340    191   325  155    0    
0   25 : cpustat 363504    341 363676      0
size-256(DMA)          0      0   4096    1    1 : tunables   24   12    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   25 : cpustat      0      0      0      0
size-256             123    123   4096    1    1 : tunables   24   12    0 : 
slabdata    123    123      0 : globalstat     406    162   342  215    0   
24   25 : cpustat   1870    390   2135      2
size-192(DMA)          0      0   4096    1    1 : tunables   24   12    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   25 : cpustat      0      0      0      0
size-192             444    444   4096    1    1 : tunables   24   12    0 : 
slabdata    444    444      0 : globalstat    1830    947  1780  142    0   
25   25 : cpustat   3542   1794   4784    109
size-128(DMA)          0      0    140   28    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   60 : cpustat      0      0      0      0
size-128             576    784    140   28    1 : tunables   32   16    0 : 
slabdata     28     28      0 : globalstat    1168    778    28    0    0    
0   60 : cpustat   3220     94   2712     26
size-96(DMA)           0      0    108   36    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   68 : cpustat      0      0      0      0
size-96             3010   3312    108   36    1 : tunables   32   16    0 : 
slabdata     92     92      0 : globalstat    4425   3308    93    0    0    
0   68 : cpustat  41989    349  39274     70
size-64(DMA)           0      0     76   50    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    
0   82 : cpustat      0      0      0      0
size-64             1082   1750     76   50    1 : tunables   32   16    0 : 
slabdata     35     35      0 : globalstat    3215   1716    36    1    0    
0   82 : cpustat   8105    241   7170    109
size-32(DMA)           0      0     44   84    1 : tunables   32   16    0 : 
slabdata      0      0      0 : globalstat       0      0     0    0    0    0  
116 : cpustat      0      0      0      0
size-32            35280  48972     44   84    1 : tunables   32   16    0 : 
slabdata    583    583      0 : globalstat  122579  49472   591    0    0    0  
116 : cpustat 153692   8138 121103   5454
kmem_cache           112    120    164   24    1 : tunables   32   16    0 : 
slabdata      5      5      0 : globalstat     112    112     5    0    0    
0   56 : cpustat     74     37      0      0

 # cat /proc/meminfo
MemTotal:       253708 kB
MemFree:         26364 kB
Buffers:           492 kB
Cached:          40332 kB
SwapCached:       1732 kB
Active:          38104 kB
Inactive:        36096 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       253708 kB
LowFree:         26364 kB
SwapTotal:      530104 kB
SwapFree:       524816 kB
Dirty:               4 kB
Writeback:        3536 kB
Mapped:          35468 kB
Slab:           141532 kB
Committed_AS:    67944 kB
PageTables:       4940 kB
VmallocTotal:   778204 kB
VmallocUsed:       920 kB
VmallocChunk:   777284 kB



Software Environment:
# sh /usr/src/linux/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux volare 2.5.75-bk1 #1 Fri Jul 11 14:04:54 CDT 2003 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11z
mount                  2.11z
module-init-tools      2.4.12
e2fsprogs              1.26
jfsutils               1.0.15
xfsprogs               2.0.0
quota-tools            3.03.
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        x    1 root     root      1394238 Mar 23  
2002 /lib/libc.so.6
Dynamic linker (ldd)   2.2.5
Procps                 3.1.5
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
No Modules Loaded



Problem Description: After performing some intensive NFS testing( See plan at 
http://ltp.sf.net/nfs ), the following is caught by dmesg on the NFS client 
machine:
======================
events/0: page allocation failure. order:0, mode:0x20
(repeated over 100 times)
slab error in cache_free_debugcheck(): cache `filp': double free, or memory 
before object was overwritten
Call Trace:
 [__slab_error+33/40] __slab_error+0x21/0x28
 [kmem_cache_free+251/600] kmem_cache_free+0xfb/0x258
 [nfs_sync_file+117/136] nfs_sync_file+0x75/0x88
 [__fput+171/216] __fput+0xab/0xd8
 [__fput+171/216] __fput+0xab/0xd8
 [fput+22/28] fput+0x16/0x1c
 [filp_close+85/100] filp_close+0x55/0x64
 [put_files_struct+88/192] put_files_struct+0x58/0xc0
 [do_exit+354/776] do_exit+0x162/0x308
 [sys_exit_group+0/20] sys_exit_group+0x0/0x14
 [get_signal_to_deliver+632/652] get_signal_to_deliver+0x278/0x28c
 [do_signal+80/212] do_signal+0x50/0xd4
 [do_page_fault+0/986] do_page_fault+0x0/0x3da
 [.text.lock.filemap+35/70] .text.lock.filemap+0x23/0x46
 [vfs_write+195/208] vfs_write+0xc3/0xd0
 [sys_write+48/80] sys_write+0x30/0x50
 [do_notify_resume+48/76] do_notify_resume+0x30/0x4c
 [work_notifysig+19/21] work_notifysig+0x13/0x15

====================== 
This may be a slab or NFS issue, but since the page allocator messages came 
first, I figured that's the best place to start.  BTW, the machine remains 
responsive after the slab error. However, all the NFS activity stops and I must 
kill the NFS tests if I want the system to respond to any commands.


Steps to reproduce: Execute the test scenario described in the NFS testplan and 
observer the client's nfs client calls:

 # watch -n1 nfsstat -c

When these stop....Bingo!


