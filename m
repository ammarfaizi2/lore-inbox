Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287183AbSAPTE4>; Wed, 16 Jan 2002 14:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287134AbSAPTEt>; Wed, 16 Jan 2002 14:04:49 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:23330 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287158AbSAPTEd>; Wed, 16 Jan 2002 14:04:33 -0500
Date: Wed, 16 Jan 2002 20:04:59 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Rik van Riel <riel@conectiva.com.br>
Subject: Rik spreading bullshit about VM
Message-ID: <20020116200459.E835@athlon.random>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

I read here:

	http://linux.html.it/articoli/rik_van_riel_ita1.htm

	[..] La nuova VM ha migliori performance rispetto alla vecchia sui
	tipici sistemi desktop ... ma fa fiasco terribilmente su più sistemi di
	quanto non lo facesse la vecchia VM. Redhat, per esempio, non ha potuto
	inserire la nuova VM nella sua distribuzione perché cadrebbe a pezzi per
	i database server, [..]

This is total bullshit. If there's something where the -aa VM is good
are the DBMS, that was designed for it basically, very lightweight,
basically no VM overhead also under very heavy I/O.

If redhat doesn't use the -aa VM into their kernels that's either a
political decision or they're not good enough at the VM. I can tell you
there are an huge number of users very happy about the -aa VM mainly on
DBMS, I know some redhat partner is also using the -aa VM for their
internal DBMS work (incidentally I assume rh kernels aren't good enough
for them?).  I don't care much of interviews, real people will make their
choice about the VM based on facts anyways, you may forbid someone to
try or you may convince someone that doesn't need much VM anyways saying
weird things like "collapse under high load or breaks on databases", but
still it's annoying to read such a bullshit and have people sending
emails to you about stuff that it isn't true.

So if you can proof any of your statements with numbers about
regressions with DB with -aa VM compared to 2.4.9 or
2.4.9+ac/rh/whatever please let us know. I have an huge amount of doc to
proof the exact opposite (the first few impressive emails I found are
attached) and most important I don't have a single bugreport about the
current 2.4.18pre2aa2 VM (except perhaps the bdflush wakeup that seems
to be a little too late and that deals to lower numbers with slow write
load etc.., fixable with bdflush tuning). Mainline VM kills too easily,
this is fixed in -aa VM and -aa VM has a number of other issues
resolved, but mainline 2.4 vm isn't that far either. In the last few
days I was playing with pte-highmem, soon I will spend some time merging
-aa VM into mainline with Marcelo if he likes to.

Andrea

PS. I know the interviewer and he's usually very accurate, so I don't
think this could be a misunderstanding where you say one thing and they
writer another one just to create troubles.

--2fHTh5uZTiUOsy+g
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from Hermes.suse.de (Hermes.suse.de [10.10.96.4])
	by Wotan.suse.de (Postfix) with ESMTP id C06368506B
	for <andrea@wotan.suse.de>; Tue, 13 Nov 2001 14:18:40 +0100 (CET)
Received: by Hermes.suse.de (Postfix)
	id B062F5D846; Tue, 13 Nov 2001 14:18:40 +0100 (MET)
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by Hermes.suse.de (Postfix) with ESMTP
	id 76E1A5D624; Tue, 13 Nov 2001 14:18:40 +0100 (MET)
Received: from vger.kernel.org (vger.kernel.org [199.183.24.194])
	by Cantor.suse.de (Postfix) with ESMTP
	id 2B8CC1E7B1; Tue, 13 Nov 2001 14:18:40 +0100 (MET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277382AbRKMNMb>; Tue, 13 Nov 2001 08:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278770AbRKMNMW>; Tue, 13 Nov 2001 08:12:22 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:42954 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S277382AbRKMNMI>; Tue, 13 Nov 2001 08:12:08 -0500
Received: from sap-ag.de (smtpde02)
  by smtpde02.sap-ag.de (out) with ESMTP id OAA14575
  for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2001 14:15:02 +0100 (MEZ)
Message-ID: <3BF11C21.8090809@sap.com>
Date: Tue, 13 Nov 2001 14:12:01 +0100
From: Willi =?ISO-8859-1?Q?N=FC=DFer?= <wilhelm.nuesser@sap.com>
Organization: SAP AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Performance tests 2.4.7 SuSE / Red Hat vs. 2.4.14 (pre8)
Content-Type: text/plain; charset=us-ascii; format=flowed
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit

Hi,

on LKML there were many discussions about the performance
of recent kernels. We did some test, too, and perhaps their
outcome is interesting to someone:

we tested in long time runs the performance of distributor
provide kernels based on 2.4.7 vs. the new stock 2.4.14 (pre 8).


1) Test description:
The test suite we use for our QA and stress tests consists of a
so-called "standard SAP SD benchmark". This benchmark tries to emulate a
typical user load on a SAP system. It consists of a benchmark driver
which simulates multiple users logging into the system and starting
transactions which consist of several dialog steps. The relevant
performance quantity is therefore based on the throughput, i.e. dialog
steps per second. More technically speaking the typical work load this
benchmark generates is dominated by m[map, copy], string operations and
integer operations. It has a huge memory footprint / working set
(approx. 2 GB). It tests mainly the CPU performance and the VM
behaviour. Network performance and  disk IO (for the database) are
much less important.

Test hardware:
4 way Dell, 4 GB physical RAM, SCSI/RAID subsystem,
DB runs on FS.

Test setting:
we configured the SAP system for 4GB and measured the dialog steps per
second for a situation where only 1 GB was activated at boot time.
This led to heavy swapping load over several hours to days.
The results were checked several times.

2) Main result:
Dialog steps per second of a typical test series:

	2.4.7			2.4.14
-----------------------------------------
	8.59			15.47
	4.40			14.76
	2.67			11.61
	2.30			14.63
	1.87			14.42
	1.65			15.30	
	1.26			15.02	
	1.68			14.53
	1.17 			15.23
	1.80			12.82
	1.10			14.59
	1.20			16.09
	1.26			14.38
	1.34			15.41


Two aspects seem to be reproduceable:
	1) whereas 2.4.7 shows a significant degradation over time
	2.4.14 remains stable.
	
	2) the asymptotic behaviour of the 2.4.14 based kernel is faster
	than 2.4.7 by a	_factor_ of around _10_. Compared to
	our previous experiences with 2.2 ad 2.4 based this is
	incredible... (OK, I don't want to become enthusiastic :-))


				
3) Details of typical runs:

2.4.7:
------

a)
vmstat 5:

          procs                      memory    swap          io     system
            cpu
        r  b  w   swpd   free   buff  cache  si  so    bi    bo   in
cs  us
        sy  id
        0 18  0 1718772   4692    380   9404  56  45    60    48   43    71
1   0  98
        0 15  1 1725360   5824    384   9384 5102 692  5109   713  410  1155
        2   1  96
        0 13  0 1723960   4824    372   9308 3316 467  3316   478  390   925
        2   2  96
        0 21  1 1719720   5576    368   9320 3973 1162  3978  1197  494 
   887
         3   2  95
        0 21  1 1727092   4732    368   9316 1539 1187  1539  1191  419 
   399
         1   1  98
        0 16  1 1726992   4752    368   9268 4510 951  4517   982  432   956
        4   3  94


b)
Top 10 of /proc/profile:
5785008 default_idle                             90390.7500
        10132 blk_get_queue                            126.6500
         6744 swap_out_pmd                              22.1842
         5839 refill_inactive_scan                      19.2072
         3451 __wake_up                                 17.9740
         9004 __get_swap_page                           13.7256
          402 __free_pages                              12.5625
         1143 __remove_inode_page                       10.2054
          469 add_wait_queue_exclusive                   9.7708
         3398 bounce_end_io_read                         9.2337


c)
meminfo during run:
               total:    used:    free:  shared: buffers:  cached:
Mem:  1051394048 1047044096  4349952 443473920  1052672 294608896
Swap: 4294934528 1314680832 2980253696
MemTotal:      1026752 kB
MemFree:          4248 kB
MemShared:      433080 kB
Buffers:          1028 kB
Cached:          20900 kB
SwapCached:     266804 kB
Active:         694700 kB
Inact_dirty:     19296 kB
Inact_clean:      7816 kB
Inact_target:    12836 kB
HighTotal:      131072 kB
HighFree:         1460 kB
LowTotal:       895680 kB
LowFree:          2788 kB
SwapTotal:     4194272 kB
SwapFree:      2910404 kB
NrSwapPages:    727602 pages


###################################################################

2.4.14:
--------

a) vmstat 5:
          procs                      memory    swap          io     system
            cpu
        r  b  w   swpd   free   buff  cache  si  so    bi    bo   in
cs  us
        sy  id
22  0  3 898668   6248    472 682160 273 108   298   187   67   391  55
         3  42
11  1  5 898696   2676    836 684692 2661 489  2813  1576  564  2570  91
         9   0
21  3  4 899164   5824    512 684520 2863 666  2947  2096  595  2517  77
         9  14
15  2  2 899628   5212    440 683816 3134 658  3260  2023  647  2631  89
         4   7
23  5  4 899796   5284    452 684860 2726 824  2842  2297  641  2552  81
         5  14
16  7  4 899700   6056    400 683916 3250 788  3346  2079  656  2527  89
         5   6



b) /proc/profile:
219002 default_idle                             3421.9062
          604 fget                                       9.4375
          452 system_call                                8.0714
          354 sock_poll                                  7.3750
          488 wake_up_process                            5.0833
         2123 scsi_dispatch_cmd                          4.9144
          230 add_wait_queue_exclusive                   4.7917
          269 mark_page_accessed                         4.2031
           55 RDOUTDOOR                                  3.4375
          197 __generic_copy_to_user                     3.0781

Despite a comparable swapping rate the 2.4.14 runs much more smooth.
One reason could be that the VM has stepped almost completely out of the
way...


c)
meminfo during run:
               total:    used:    free:  shared: buffers:  cached:
Mem:  1052712960 1046528000  6184960        0   319488 856850432
Swap: 4294934528 1313320960 2981613568
MemTotal:      1028040 kB
MemFree:          6040 kB
MemShared:           0 kB
Buffers:           312 kB
Cached:         714576 kB
SwapCached:     122192 kB
Active:         851084 kB
Inactive:       113592 kB
HighTotal:      131072 kB
HighFree:         2044 kB
LowTotal:       896968 kB
LowFree:          3996 kB
SwapTotal:     4194272 kB
SwapFree:      2911732 kB


###########################################################################

4) Our conclusion:

Although we still see some problems with the 2.4.14 based kernel it
looks really promising for us. A _stable_ increase of a factor of
10 in memory critical situations is impressive. Especially since our
customer tend to steer every system finally into this load region ;-)

Great work!


Best regards
	Willi Nuesser
	SAP LinuxLab

PS:
Please CC me, since I'm not on LKML

PPS:
In case you need any further info please mail me. We can put more
detailed data on our ftp server.










-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--2fHTh5uZTiUOsy+g
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from Hermes.suse.de (Hermes.suse.de [10.10.96.4])
	by Wotan.suse.de (Postfix) with ESMTP id 1AE0985060
	for <andrea@wotan.suse.de>; Tue, 13 Nov 2001 14:36:09 +0100 (CET)
Received: by Hermes.suse.de (Postfix)
	id 0F9B15D83F; Tue, 13 Nov 2001 14:36:09 +0100 (MET)
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by Hermes.suse.de (Postfix) with ESMTP
	id D84CC5D62A; Tue, 13 Nov 2001 14:36:08 +0100 (MET)
Received: from vger.kernel.org (vger.kernel.org [199.183.24.194])
	by Cantor.suse.de (Postfix) with ESMTP
	id AB80A1E7B2; Tue, 13 Nov 2001 14:36:08 +0100 (MET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281526AbRKMNbW>; Tue, 13 Nov 2001 08:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281623AbRKMNbM>; Tue, 13 Nov 2001 08:31:12 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:53983 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S281526AbRKMNbB>; Tue, 13 Nov 2001 08:31:01 -0500
Received: from sap-ag.de (smtpde02)
  by smtpde02.sap-ag.de (out) with ESMTP id OAA28930;
  Tue, 13 Nov 2001 14:33:55 +0100 (MEZ)
Message-ID: <816D93CCC927D31188570008C75D1DE106DEA661@dbwdfx1a.wdf.sap-ag.de>
From: "Nuesser, Wilhelm" <wilhelm.nuesser@sap.com>
To: "'arjanv@redhat.com'" <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Performance tests 2.4.7 SuSE / Red Hat vs. 2.4.14 (pre8)
Date: Tue, 13 Nov 2001 14:30:52 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Arjan van de Ven [mailto:arjanv@redhat.com]
> Sent: Dienstag, 13. November 2001 14:23
> To: Nuesser, Wilhelm
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Performance tests 2.4.7 SuSE / Red Hat vs. 2.4.14 (pre8)
> 
> 
> 
> > 4) Our conclusion:
> > 
> > Although we still see some problems with the 2.4.14 based kernel it
> > looks really promising for us. A _stable_ increase of a factor of
> > 10 in memory critical situations is impressive. Especially since our
> > customer tend to steer every system finally into this load 
> region ;-)
> 
> Could you please also test the 2.4.9 RH kernel ?
> 

We did this, you know ...

The results were comparable to the 2.4.7 results, at least for the
kernels 2.4.9-[1,6]enterprise.

Best regards
	Willi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--2fHTh5uZTiUOsy+g
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from Hermes.suse.de (Hermes.suse.de [10.10.96.4])
	by Wotan.suse.de (Postfix) with ESMTP id 30FE185070
	for <andrea@wotan.suse.de>; Wed, 14 Nov 2001 14:47:23 +0100 (CET)
Received: by Hermes.suse.de (Postfix)
	id 24BFB5D848; Wed, 14 Nov 2001 14:47:23 +0100 (MET)
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by Hermes.suse.de (Postfix) with ESMTP
	id 112F95D843; Wed, 14 Nov 2001 14:47:23 +0100 (MET)
Received: from vger.kernel.org (vger.kernel.org [199.183.24.194])
	by Cantor.suse.de (Postfix) with ESMTP
	id D4DF51E439; Wed, 14 Nov 2001 14:47:22 +0100 (MET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280592AbRKNNpX>; Wed, 14 Nov 2001 08:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280591AbRKNNpN>; Wed, 14 Nov 2001 08:45:13 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:40610 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S280592AbRKNNpB>; Wed, 14 Nov 2001 08:45:01 -0500
Received: from sap-ag.de (smtpde02)
  by smtpde02.sap-ag.de (out) with ESMTP id OAA13016
  for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2001 14:47:57 +0100 (MEZ)
Message-ID: <3BF27557.30007@sap.com>
Date: Wed, 14 Nov 2001 14:44:55 +0100
From: Willi =?ISO-8859-1?Q?N=FC=DFer?= <wilhelm.nuesser@sap.com>
Organization: SAP AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Comparison of PAE and Non-PAE 2..4.14 (p8) in high load
Content-Type: text/plain; charset=us-ascii; format=flowed
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit

Hi,

after my first posting to lkml where we compared distributor
provided kernels vs. a plain 2.4.14-pre8 it was pointed
out that between PAE and non-PAE kernels some performance
differences might exist.


We checked this last night and here are the first results.
Again,
a) the relevant quantity dialog steps per second is a
measure for the throughput our application servers runs.
b) our application server and the corresponding database
(SAP DB) run on 4 way Dell, 1 GB at boot time enabled.

Results:
---------

2.4.7 
	2.4.14p8 PAE		2.4.14p4 non- PAE
-------------------------------------------------------------
   1.80		13.42            	15.47
   1.10		13.28            	14.76
   1.20 		14.08            	14.63
   1.26     	13.17            	15.30
   1.35		13.41            	14.51


This means that we did see a performance decrease of about
6 % compared to 2.4.14p8 nonPAE but still 2.4.14p8 is an order
of magnitude faster than 2.4.7

-- 
Best regards
	Willi

-----------------------------------
Willi Nuesser
SAP Linuxlab

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--2fHTh5uZTiUOsy+g
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from Hermes.suse.de (Hermes.suse.de [10.10.96.4])
	by Wotan.suse.de (Postfix) with ESMTP id C975A8509E
	for <andrea@wotan.suse.de>; Wed, 14 Nov 2001 16:50:14 +0100 (CET)
Received: by Hermes.suse.de (Postfix)
	id B3D265D848; Wed, 14 Nov 2001 16:50:14 +0100 (MET)
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by Hermes.suse.de (Postfix) with ESMTP
	id 3DCEB5D852; Wed, 14 Nov 2001 16:50:14 +0100 (MET)
Received: from vger.kernel.org (vger.kernel.org [199.183.24.194])
	by Cantor.suse.de (Postfix) with ESMTP
	id 0401E1E44F; Wed, 14 Nov 2001 16:50:14 +0100 (MET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280657AbRKNPiu>; Wed, 14 Nov 2001 10:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280656AbRKNPiH>; Wed, 14 Nov 2001 10:38:07 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:47523 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S280655AbRKNPgT>; Wed, 14 Nov 2001 10:36:19 -0500
Received: from sap-ag.de (smtpde02)
  by smtpde02.sap-ag.de (out) with ESMTP id QAA13117;
  Wed, 14 Nov 2001 16:39:14 +0100 (MEZ)
Message-ID: <3BF28F6C.90008@sap.com>
Date: Wed, 14 Nov 2001 16:36:12 +0100
From: Willi =?ISO-8859-1?Q?N=FC=DFer?= <wilhelm.nuesser@sap.com>
Organization: SAP AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Comparison of PAE and Non-PAE 2..4.14 (p8) in high load
In-Reply-To: <3BF27557.30007@sap.com> <3BF2837B.4B63FBA5@didntduck.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit

Brian Gerst wrote:

 
>>
>>Results:
>>---------
>>
>>2.4.7
>>        2.4.14p8 PAE            2.4.14p4 non- PAE
>>-------------------------------------------------------------
>>   1.80         13.42                   15.47
>>   1.10         13.28                   14.76
>>   1.20                 14.08                   14.63
>>   1.26         13.17                   15.30
>>   1.35         13.41                   14.51
>>
>>This means that we did see a performance decrease of about
>>6 % compared to 2.4.14p8 nonPAE but still 2.4.14p8 is an order
>>of magnitude faster than 2.4.7
>>
> 
> PAE mode increases the size of the page table entries to 64-bits, and
> the x86 doesn't do 64-bit operations very well.  Plus it has three 

> levels of tables to work with instead of two.  


Yes, I know the difference. The reason for this post was not blind
curiosity but the presumption that the great performance increase of 
2.4.14p8 we reported was mainly due to the PAE enabling in the 2.4.7 and 
non-PAE-enabling 2.4.14p8 in our first test.

The tests above show that this is not the case. Even with PAE 2.4.14 is
faster by an order of magnitude.

The other info we did find interesting is the actual amount of 
difference between PAE and nonPAE. The 6% we got fit very well in some
estimates I found on lkml.

-- 
Best regards
Willi

-----------------------------------
Willi Nuesser
SAP Linuxlab

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--2fHTh5uZTiUOsy+g--
