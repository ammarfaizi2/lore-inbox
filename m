Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263377AbSJWKEi>; Wed, 23 Oct 2002 06:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263960AbSJWKEh>; Wed, 23 Oct 2002 06:04:37 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:17302 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S263377AbSJWKEh> convert rfc822-to-8bit;
	Wed, 23 Oct 2002 06:04:37 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: netdev@oss.sgi.com
Subject: tuning linux for high network performance?
Date: Wed, 23 Oct 2002 12:18:18 +0200
User-Agent: KMail/1.4.1
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210231218.18733.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I've got this video server serving video for VoD. problem is the P4 1.8 seems 
to be maxed out by a few system calls. The below output is for ~50 clients 
streaming at ~4.5Mbps. if trying to increase this to ~70, the CPU maxes out.

Does anyone have an idea?

bash-2.05# readprofile | sort -rn +2 | head -30
154203 default_idle                             2409.4219
212723 csum_partial_copy_generic                916.9095
100164 handle_IRQ_event                         695.5833
 24979 system_call                              390.2969
 37300 e1000_intr                               388.5417
119699 ide_intr                                 340.0540
 30598 skb_release_data                         273.1964
 40740 do_softirq                               195.8654
131818 do_wp_page                               164.7725
  9935 fget                                     155.2344
 24747 kfree                                    154.6687
 10911 del_timer                                113.6562
 11683 ip_conntrack_find_get                     91.2734
  4120 sock_poll                                 85.8333
  9357 ip_ct_find_proto                          83.5446
  5194 sock_wfree                                81.1562
  4929 add_wait_queue                            77.0156
  8361 flush_tlb_page                            74.6518
  4571 remove_wait_queue                         71.4219
  2191 __brelse                                  68.4688
 29477 skb_clone                                 68.2338
  8562 do_gettimeofday                           59.4583
  5673 process_timeout                           59.0938
 11097 tcp_v4_send_check                         57.7969
  6124 kfree_skbmem                              54.6786
 17115 tcp_poll                                  53.4844
 21130 nf_hook_slow                              52.8250
  8299 ip_ct_refresh                             51.8687
 15429 __kfree_skb                               50.7533
  1059 lru_cache_del                             46.0435


roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

