Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbTH2LBz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 07:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTH2LBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 07:01:55 -0400
Received: from [213.69.232.58] ([213.69.232.58]:57098 "HELO
	flapp.schottelius.org") by vger.kernel.org with SMTP
	id S264522AbTH2LBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 07:01:34 -0400
Date: Fri, 29 Aug 2003 11:53:06 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Nick Piggin <piggin@cyberone.com.au>, Ross Clarke <encrypted@geekz.za.net>,
       Linux-Admin <linux-admin@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Crazy load average & unkillable processes
Message-ID: <20030829095306.GB1197@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Nick Piggin <piggin@cyberone.com.au>,
	Ross Clarke <encrypted@geekz.za.net>,
	Linux-Admin <linux-admin@vger.kernel.org>,
	linux-kernel@vger.kernel.org
References: <3F4D339A.8010907@geekz.za.net> <20030828085549.GB264@schottelius.org> <3F4DCC65.2010106@cyberone.com.au> <20030829090129.GE690@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <20030829090129.GE690@schottelius.org>
User-Agent: Mutt/1.4i
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux flapp 2.6.0-test4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Btw, the only thing I can see now is=20
nico@flapp:~/archiv $ dmesg=20
spurious 8259A interrupt: IRQ7.

not more..
and now I have to reboot as typing this mail is very hard as the system is
very slow. with no load! (i am even using the preempt patch..)

Nico

Nico Schottelius [Fri, Aug 29, 2003 at 11:01:29AM +0200]:
> I am attaching /proc/meminfo,slapinfo,uptime from now.
> The system is f*** slow..
> And I am currently just able to write this, moving windows
> in X is more than painful!
>=20
> Nico
>=20
> Nick Piggin [Thu, Aug 28, 2003 at 07:33:25PM +1000]:
> > Nico Schottelius wrote:
> >=20
> > >Very interesting..
> > >with the test4 I experiene the same/similar problems on my laptop..
> > >all of sudden yesterday several programs died -> Out of Memory.
> > >I ran
> > >  Xfree
> > >  dhcpcd
> > >  opera=20
> > >  several xterms (about 6)
> > >  qmail
> > >  named
> > >
> > >first opera was Out of Memory, then died the whole X system with all
> > >xterms and X beeing Out of Memory.
> > >
> > >MemTotal:       385600 kB
> > >
> > >which should be more than enough!
> > >
> >=20
> > You might have a process with a memory leak. How much free memory do
> > you have before everything dies? How much swapping activity is going
> > on? What do /proc/meminfo and /proc/slabinfo say?
> >=20
> >=20
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-admin" =
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
>=20
> --=20
> quote:   there are two time a day you should do nothing: before 12 and af=
ter 12
>          (Nico Schottelius after writin' a very senseless email)
> cmd:     echo God bless America | sed 's/.*\(A.*\)$/Why \1?/'
> pgp:     new id: 0x8D0E27A4 | ftp.schottelius.org/pub/familiy/nico/pgp-ke=
y.new
> url:     http://nerd-hosting.net - domains for nerds (from a nerd)

> MemTotal:       385600 kB
> MemFree:         76904 kB
> Buffers:         16016 kB
> Cached:         227236 kB
> SwapCached:          0 kB
> Active:          76576 kB
> Inactive:       217944 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       385600 kB
> LowFree:         76904 kB
> SwapTotal:           0 kB
> SwapFree:            0 kB
> Dirty:             220 kB
> Writeback:           0 kB
> Mapped:          67192 kB
> Slab:            10628 kB
> Committed_AS:    64664 kB
> PageTables:        692 kB
> VmallocTotal:   647132 kB
> VmallocUsed:      1048 kB
> VmallocChunk:   645956 kB

> slabinfo - version: 2.0
> # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesp=
erslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_s=
labs> <num_slabs> <sharedavail>
> fib6_nodes             5    113     32  113    1 : tunables  120   60    =
0 : slabdata      1      1      0
> ip6_dst_cache          5     17    224   17    1 : tunables  120   60    =
0 : slabdata      1      1      0
> ndisc_cache            1     24    160   24    1 : tunables  120   60    =
0 : slabdata      1      1      0
> raw6_sock              0      0    544    7    1 : tunables   54   27    =
0 : slabdata      0      0      0
> udp6_sock              1      7    544    7    1 : tunables   54   27    =
0 : slabdata      1      1      0
> tcp6_sock             11     12    960    4    1 : tunables   54   27    =
0 : slabdata      3      3      0
> ip_fib_hash            9    202     16  202    1 : tunables  120   60    =
0 : slabdata      1      1      0
> isofs_inode_cache      0      0    352   11    1 : tunables   54   27    =
0 : slabdata      0      0      0
> unix_sock             28     44    352   11    1 : tunables   54   27    =
0 : slabdata      4      4      0
> ip_mrt_cache           0      0     96   40    1 : tunables  120   60    =
0 : slabdata      0      0      0
> tcp_tw_bucket          1     30    128   30    1 : tunables  120   60    =
0 : slabdata      1      1      0
> tcp_bind_bucket       18    202     16  202    1 : tunables  120   60    =
0 : slabdata      1      1      0
> tcp_open_request       0      0     96   40    1 : tunables  120   60    =
0 : slabdata      0      0      0
> inet_peer_cache        1     59     64   59    1 : tunables  120   60    =
0 : slabdata      1      1      0
> secpath_cache          0      0    128   30    1 : tunables  120   60    =
0 : slabdata      0      0      0
> xfrm_dst_cache         0      0    288   13    1 : tunables   54   27    =
0 : slabdata      0      0      0
> ip_dst_cache          98    104    288   13    1 : tunables   54   27    =
0 : slabdata      8      8      0
> arp_cache              4     30    128   30    1 : tunables  120   60    =
0 : slabdata      1      1      0
> raw4_sock              0      0    416    9    1 : tunables   54   27    =
0 : slabdata      0      0      0
> udp_sock               3      9    416    9    1 : tunables   54   27    =
0 : slabdata      1      1      0
> tcp_sock              22     36    832    9    2 : tunables   54   27    =
0 : slabdata      4      4      0
> flow_cache             0      0     96   40    1 : tunables  120   60    =
0 : slabdata      0      0      0
> xfs_acl                0      0    304   13    1 : tunables   54   27    =
0 : slabdata      0      0      0
> xfs_chashlist          0      0     20  169    1 : tunables  120   60    =
0 : slabdata      0      0      0
> xfs_ili                0      0    140   28    1 : tunables  120   60    =
0 : slabdata      0      0      0
> xfs_ifork              0      0     56   67    1 : tunables  120   60    =
0 : slabdata      0      0      0
> xfs_efi_item           0      0    260   15    1 : tunables   54   27    =
0 : slabdata      0      0      0
> xfs_efd_item           0      0    260   15    1 : tunables   54   27    =
0 : slabdata      0      0      0
> xfs_buf_item           0      0    148   26    1 : tunables  120   60    =
0 : slabdata      0      0      0
> xfs_dabuf              0      0     16  202    1 : tunables  120   60    =
0 : slabdata      0      0      0
> xfs_da_state           0      0    336   11    1 : tunables   54   27    =
0 : slabdata      0      0      0
> xfs_trans              0      0    592   13    2 : tunables   54   27    =
0 : slabdata      0      0      0
> xfs_inode              0      0    368   10    1 : tunables   54   27    =
0 : slabdata      0      0      0
> xfs_btree_cur          0      0    132   29    1 : tunables  120   60    =
0 : slabdata      0      0      0
> xfs_bmap_free_item      0      0     12  253    1 : tunables  120   60   =
 0 : slabdata      0      0      0
> page_buf_t             0      0    224   17    1 : tunables  120   60    =
0 : slabdata      0      0      0
> linvfs_icache          0      0    352   11    1 : tunables   54   27    =
0 : slabdata      0      0      0
> reiser_inode_cache      0      0    384   10    1 : tunables   54   27   =
 0 : slabdata      0      0      0
> devfsd_event           0      0     20  169    1 : tunables  120   60    =
0 : slabdata      0      0      0
> ext2_inode_cache       0      0    480    8    1 : tunables   54   27    =
0 : slabdata      0      0      0
> ext2_xattr             0      0     48   78    1 : tunables  120   60    =
0 : slabdata      0      0      0
> journal_handle         8    126     28  126    1 : tunables  120   60    =
0 : slabdata      1      1      0
> journal_head          45    156     48   78    1 : tunables  120   60    =
0 : slabdata      2      2      0
> revoke_table           2    253     12  253    1 : tunables  120   60    =
0 : slabdata      1      1      0
> revoke_record          0      0     16  202    1 : tunables  120   60    =
0 : slabdata      0      0      0
> ext3_inode_cache    5656   5656    480    8    1 : tunables   54   27    =
0 : slabdata    707    707      0
> ext3_xattr             0      0     48   78    1 : tunables  120   60    =
0 : slabdata      0      0      0
> dquot                  0      0    128   30    1 : tunables  120   60    =
0 : slabdata      0      0      0
> eventpoll_pwq          0      0     36  101    1 : tunables  120   60    =
0 : slabdata      0      0      0
> eventpoll_epi          0      0     96   40    1 : tunables  120   60    =
0 : slabdata      0      0      0
> kioctx                 0      0    160   24    1 : tunables  120   60    =
0 : slabdata      0      0      0
> kiocb                  0      0    160   24    1 : tunables  120   60    =
0 : slabdata      0      0      0
> dnotify_cache          0      0     20  169    1 : tunables  120   60    =
0 : slabdata      0      0      0
> file_lock_cache       18     42     92   42    1 : tunables  120   60    =
0 : slabdata      1      1      0
> fasync_cache           1    202     16  202    1 : tunables  120   60    =
0 : slabdata      1      1      0
> shmem_inode_cache      4      9    416    9    1 : tunables   54   27    =
0 : slabdata      1      1      0
> idr_layer_cache        0      0    136   28    1 : tunables  120   60    =
0 : slabdata      0      0      0
> posix_timers_cache      0      0     80   48    1 : tunables  120   60   =
 0 : slabdata      0      0      0
> uid_cache              5    113     32  113    1 : tunables  120   60    =
0 : slabdata      1      1      0
> deadline_drq           0      0     52   72    1 : tunables  120   60    =
0 : slabdata      0      0      0
> as_arq                59     59     64   59    1 : tunables  120   60    =
0 : slabdata      1      1      0
> blkdev_requests       48     48    160   24    1 : tunables  120   60    =
0 : slabdata      2      2      0
> biovec-BIO_MAX_PAGES    256    260   3072    5    4 : tunables   24   12 =
   0 : slabdata     52     52      0
> biovec-128           256    260   1536    5    2 : tunables   24   12    =
0 : slabdata     52     52      0
> biovec-64            260    260    768    5    1 : tunables   54   27    =
0 : slabdata     52     52      0
> biovec-16            256    260    192   20    1 : tunables  120   60    =
0 : slabdata     13     13      0
> biovec-4             256    295     64   59    1 : tunables  120   60    =
0 : slabdata      5      5      0
> biovec-1             308    404     16  202    1 : tunables  120   60    =
0 : slabdata      2      2      0
> bio                  317    354     64   59    1 : tunables  120   60    =
0 : slabdata      6      6      0
> sock_inode_cache      65     80    384   10    1 : tunables   54   27    =
0 : slabdata      8      8      0
> skbuff_head_cache    180    180    192   20    1 : tunables  120   60    =
0 : slabdata      9      9      0
> sock                   3     12    320   12    1 : tunables   54   27    =
0 : slabdata      1      1      0
> proc_inode_cache      63     77    352   11    1 : tunables   54   27    =
0 : slabdata      7      7      0
> sigqueue              27     27    144   27    1 : tunables  120   60    =
0 : slabdata      1      1      0
> radix_tree_node     3045   3045    260   15    1 : tunables   54   27    =
0 : slabdata    203    203      0
> bdev_cache             2     40     96   40    1 : tunables  120   60    =
0 : slabdata      1      1      0
> mnt_cache             15     59     64   59    1 : tunables  120   60    =
0 : slabdata      1      1      0
> inode_cache          823    836    352   11    1 : tunables   54   27    =
0 : slabdata     76     76      0
> dentry_cache        7988   7992    160   24    1 : tunables  120   60    =
0 : slabdata    333    333      0
> filp                 666    750    128   30    1 : tunables  120   60    =
0 : slabdata     25     25      0
> names_cache            1      1   4096    1    1 : tunables   24   12    =
0 : slabdata      1      1      0
> buffer_head         4870   4896     52   72    1 : tunables  120   60    =
0 : slabdata     68     68      0
> mm_struct             50     66    352   11    1 : tunables   54   27    =
0 : slabdata      6      6      0
> vm_area_struct      1236   1534     64   59    1 : tunables  120   60    =
0 : slabdata     26     26      0
> fs_cache              51    113     32  113    1 : tunables  120   60    =
0 : slabdata      1      1      0
> files_cache           49     63    416    9    1 : tunables   54   27    =
0 : slabdata      7      7      0
> signal_cache          72    118     64   59    1 : tunables  120   60    =
0 : slabdata      2      2      0
> sighand_cache         56     66   1312    3    1 : tunables   24   12    =
0 : slabdata     22     22      0
> task_struct           80     80   1536    5    2 : tunables   24   12    =
0 : slabdata     16     16      0
> pte_chain           7773   8814     32  113    1 : tunables  120   60    =
0 : slabdata     78     78      0
> pgd                   50     50   4096    1    1 : tunables   24   12    =
0 : slabdata     50     50      0
> size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    =
0 : slabdata      0      0      0
> size-131072            0      0 131072    1   32 : tunables    8    4    =
0 : slabdata      0      0      0
> size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    =
0 : slabdata      0      0      0
> size-65536             0      0  65536    1   16 : tunables    8    4    =
0 : slabdata      0      0      0
> size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    =
0 : slabdata      0      0      0
> size-32768             0      0  32768    1    8 : tunables    8    4    =
0 : slabdata      0      0      0
> size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    =
0 : slabdata      0      0      0
> size-16384             0      0  16384    1    4 : tunables    8    4    =
0 : slabdata      0      0      0
> size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    =
0 : slabdata      0      0      0
> size-8192             71     71   8192    1    2 : tunables    8    4    =
0 : slabdata     71     71      0
> size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    =
0 : slabdata      0      0      0
> size-4096             98     98   4096    1    1 : tunables   24   12    =
0 : slabdata     98     98      0
> size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    =
0 : slabdata      0      0      0
> size-2048            134    146   2048    2    1 : tunables   24   12    =
0 : slabdata     73     73      0
> size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    =
0 : slabdata      0      0      0
> size-1024             72     80   1024    4    1 : tunables   54   27    =
0 : slabdata     20     20      0
> size-512(DMA)          0      0    512    8    1 : tunables   54   27    =
0 : slabdata      0      0      0
> size-512             169    184    512    8    1 : tunables   54   27    =
0 : slabdata     23     23      0
> size-256(DMA)          0      0    256   15    1 : tunables  120   60    =
0 : slabdata      0      0      0
> size-256              90     90    256   15    1 : tunables  120   60    =
0 : slabdata      6      6      0
> size-192(DMA)          0      0    192   20    1 : tunables  120   60    =
0 : slabdata      0      0      0
> size-192             120    120    192   20    1 : tunables  120   60    =
0 : slabdata      6      6      0
> size-128(DMA)          0      0    128   30    1 : tunables  120   60    =
0 : slabdata      0      0      0
> size-128             172    180    128   30    1 : tunables  120   60    =
0 : slabdata      6      6      0
> size-96(DMA)           0      0     96   40    1 : tunables  120   60    =
0 : slabdata      0      0      0
> size-96             1538   1560     96   40    1 : tunables  120   60    =
0 : slabdata     39     39      0
> size-64(DMA)           0      0     64   59    1 : tunables  120   60    =
0 : slabdata      0      0      0
> size-64             7375   7375     64   59    1 : tunables  120   60    =
0 : slabdata    125    125      0
> size-32(DMA)           0      0     32  113    1 : tunables  120   60    =
0 : slabdata      0      0      0
> size-32             1967   2147     32  113    1 : tunables  120   60    =
0 : slabdata     19     19      0
> kmem_cache           132    132    116   33    1 : tunables  120   60    =
0 : slabdata      4      4      0

>  11:00am  up   2:37,  15 users,  load average: 0.71, 0.42, 0.33




--=20
quote:   there are two time a day you should do nothing: before 12 and afte=
r 12
         (Nico Schottelius after writin' a very senseless email)
cmd:     echo God bless America | sed 's/.*\(A.*\)$/Why \1?/'
pgp:     new id: 0x8D0E27A4 | ftp.schottelius.org/pub/familiy/nico/pgp-key.=
new
url:     http://nerd-hosting.net - domains for nerds (from a nerd)

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/TyKCzGnTqo0OJ6QRAl1YAKCdz4MujQM1LcEUuL8eOZB1LdS6KgCfUVPG
6hXmsiltLUhpPxpr8kbXyko=
=S/bG
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
