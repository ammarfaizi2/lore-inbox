Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291144AbSBGOy2>; Thu, 7 Feb 2002 09:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291145AbSBGOyT>; Thu, 7 Feb 2002 09:54:19 -0500
Received: from cm-24-161-45-249.nycap.rr.com ([24.161.45.249]:61312 "EHLO
	incandescent.mp3revolution.net") by vger.kernel.org with ESMTP
	id <S291144AbSBGOyI>; Thu, 7 Feb 2002 09:54:08 -0500
Date: Thu, 7 Feb 2002 09:53:56 -0500
From: Andres Salomon <dilinger@mp3revolution.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: D state processes in 2.4.18-pre7-ac3
Message-ID: <20020207145356.GA4658@mp3revolution.net>
In-Reply-To: <20020207090237.GA2137@mp3revolution.net> <3C624782.14FC8C70@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C624782.14FC8C70@zip.com.au>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux incandescent 2.4.18-pre7-ac3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No messages at all, actually.  I noticed my sysrq-t made it into my logs
(although it doesn't look all too correct..), so I've included it
below.  The D-state processes themselves seem to be the only indication of
something gone wrong.  

Feb  7 02:30:01 incandescent kernel: SysRq : Show State
Feb  7 02:30:01 incandescent kernel: 
Feb  7 02:30:01 incandescent kernel:                          free                        sibling
Feb  7 02:30:01 incandescent kernel:   task             PC    stack   pid father child younger older
Feb  7 02:30:01 incandescent kernel: init          S CFFE7F2C  4628     1      0 26034               (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: keventd       S 00010000  5684     2      1             3       (L-TLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [context_thread+251/416] [kernel_thread+40/64] 
Feb  7 02:30:01 incandescent kernel: ksoftirqd_CPU S C1376000  5368     3      1             4     2 (L-TLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [ksoftirqd+114/176] [kernel_thread+40/64] 
Feb  7 02:30:01 incandescent kernel: kswapd        S C1375F88  5092     4      1             5     3 (L-TLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [interruptible_sleep_on_timeout+66/96] [wakeup_memwaiters+121/256] [kswapd+707/720] 
Feb  7 02:30:01 incandescent kernel:    [kernel_thread+40/64] 
Feb  7 02:30:01 incandescent kernel: bdflush       S 00000286  5436     5      1             6     4 (L-TLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [interruptible_sleep_on+61/80] [bdflush+149/160] [kernel_thread+40/64] 
Feb  7 02:30:01 incandescent kernel: kupdated      S C1371FC8  4772     6      1             7     5 (L-TLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [kupdate+130/272] [kernel_thread+40/64] 
Feb  7 02:30:01 incandescent kernel: kreiserfsd    S CFDDBFB4  5544     7      1            20     6 (L-TLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [interruptible_sleep_on_timeout+66/96] [reiserfs_journal_commit_thread+149/208] [kernel_thread+40/64] 
Feb  7 02:30:01 incandescent kernel: devfsd        S CF9D8000  5928    20      1           109     7 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [devfsd_read+248/944] [sys_read+150/208] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: eth1          S CF5B3F98     0   109      1           151    20 (L-TLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [interruptible_sleep_on_timeout+66/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-520802/96] [kernel_thread+40/64] 
Feb  7 02:30:01 incandescent kernel: kjournald     D CF47BE74     8   151      1           159   109 (L-TLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [__wait_on_buffer+106/144] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-645402/96] [schedule+704/752] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-636693/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-636992/96] 
Feb  7 02:30:01 incandescent kernel:    [kernel_thread+40/64] 
Feb  7 02:30:01 incandescent kernel: httpd         S CEFA1F2C  4560   159      1  1968     172   151 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_select+417/480] [kfree+146/160] [sys_select+810/1136] 
Feb  7 02:30:01 incandescent kernel:    [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: syslogd       D CEF1DE6C  3896   172      1           175   159 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [__wait_on_buffer+106/144] [_update_journal_header_block+190/240] [update_journal_header_block+21/48] [flush_journal_list+805/912] [do_journal_end+2440/2704] 
Feb  7 02:30:01 incandescent kernel:    [journal_end_sync+68/80] [reiserfs_commit_for_inode+82/128] [reiserfs_sync_file+54/80] [sys_fsync+99/176] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: klogd         R CEED8000  4828   175      1           181   172 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [do_syslog+193/736] [kmsg_read+17/32] [sys_read+150/208] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: exim          S 7FFFFFFF  2672   181      1           205   175 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: inetd         S CEF29FB0     0   205      1           208   181 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sys_rt_sigsuspend+230/256] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: ippl          S CEBE9F88   428   208      1   210     226   205 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [sys_nanosleep+278/496] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: ippl          S CEC21F28     0   210    208   211               (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_poll+188/224] [sys_poll+477/752] [end_8259A_irq+24/32] 
Feb  7 02:30:01 incandescent kernel:    [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: ippl          S 7FFFFFFF  2676   211    210                     (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+23/160] [wait_for_packet+210/320] [skb_recv_datagram+174/208] [raw_recvmsg+117/336] [inet_recvmsg+61/96] 
Feb  7 02:30:01 incandescent kernel:    [sock_recvmsg+61/192] [sock_read+142/160] [sys_read+150/208] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: oidentd       S 7FFFFFFF     0   226      1           230   208 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+23/160] [wait_for_connect+224/384] [tcp_accept+129/416] [inet_accept+48/304] [sys_accept+102/256] 
Feb  7 02:30:01 incandescent kernel:    [do_page_fault+0/1172] [sys_rt_sigaction+152/320] [sys_socketcall+179/512] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: nmbd          S CEAADF2C  4828   230      1           232   226 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: smbd          S 7FFFFFFF  5236   232      1 26861     238   230 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: sshd          S 7FFFFFFF  2672   238      1  4730     243   232 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: cron          S CE82DF88  2672   243      1           246   238 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [sys_nanosleep+278/496] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: getty         S 7FFFFFFF  2256   246      1          2055   243 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+23/160] [read_chan+941/1792] [tty_read+184/224] [sys_read+150/208] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: sshd          S 7FFFFFFF     0   308    238   313   12543       (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [normal_poll+259/287] [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: bash          S 00000000     0   313    308  1889               (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sys_wait4+862/912] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: smbd          S C8C15F2C    16 26858    232         26859       (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: smbd          S C9145F2C  3536 26859    232         26861 26858 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: smbd          S CA687F2C     0 26861    232               26859 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: screen        S 7FFFFFFF  2672  2055      1  9884   27389   246 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: bash          S 00000000   660  2056   2055  7457    2772       (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sys_wait4+862/912] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: screen        S 7FFFFFFF   584 27389      1  3561   26034  2055 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [normal_poll+259/287] [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: bash          S 00000000  2672 27391  27389 14574   14718       (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sys_wait4+862/912] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: bash          S 00000000  5444  2772   2055  3065    3239  2056 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sys_wait4+862/912] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: ssh           S 7FFFFFFF     0  3065   2772                     (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: bash          S 7FFFFFFF     0  3239   2055          3964  2772 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+23/160] [read_chan+941/1792] [tty_read+184/224] [sys_read+150/208] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: bash          S 00000000   660  3964   2055  5543    9884  3239 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sys_wait4+862/912] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: lftp          S C0BF1F28  2144  5543   3964                     (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_poll+188/224] [sys_poll+477/752] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: mutt          S CDC5DF28  2676  7457   2056                     (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_poll+188/224] [sys_poll+477/752] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: bash          S 00000000  2676  9884   2055  9517          3964 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sys_wait4+862/912] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: sshd          S 7FFFFFFF     0 12543    238 12556   31886   308 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: bash          S 00000000     0 12556  12543 12590               (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sys_wait4+862/912] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: screen        S C8A08000   660 12590  12556                     (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sys_pause+18/24] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: ncftp         D 00000282     0 14574  27391                     (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sleep_on+61/80] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-652601/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-652024/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-591726/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-654750/96] 
Feb  7 02:30:01 incandescent kernel:    [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-591574/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-591401/96] [__mark_inode_dirty+46/128] [generic_file_write+816/1872] [sock_read+142/160] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-607978/96] 
Feb  7 02:30:01 incandescent kernel:    [sys_write+150/208] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: bash          D C0079EB0     0 14718  27389          3494 27391 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [__wait_on_buffer+106/144] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-599850/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-608890/96] [do_page_fault+355/1172] [do_page_fault+0/1172] 
Feb  7 02:30:01 incandescent kernel:    [vfs_readdir+97/144] [filldir64+0/368] [sys_getdents64+79/259] [filldir64+0/368] [sys_fcntl64+128/144] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: httpd         S 7FFFFFFF    16 25786    159         25787       (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: httpd         S C801A000     0 25787    159         25788 25786 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sys_semop+907/1184] [net_tx_action+141/160] [do_softirq+90/176] [ip_queue_xmit2+0/523] [_text_lock_netfilter+182/219] 
Feb  7 02:30:01 incandescent kernel:    [skb_release_data+103/112] [kfree_skbmem+11/96] [tcp_recvmsg+1739/2032] [tcp_v4_destroy_sock+20/352] [sk_free+57/64] [tcp_close+1409/1424] 
Feb  7 02:30:01 incandescent kernel:    [__free_pages+27/32] [free_pages+26/32] [release_task+295/336] [sys_wait4+899/912] [sys_ipc+64/640] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: httpd         S C2112000     0 25788    159         25789 25787 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sys_semop+907/1184] [net_tx_action+141/160] [do_softirq+90/176] [ip_queue_xmit2+0/523] [_text_lock_netfilter+182/219] 
Feb  7 02:30:01 incandescent kernel:    [skb_release_data+103/112] [kfree_skbmem+11/96] [tcp_recvmsg+1739/2032] [tcp_v4_destroy_sock+20/352] [sk_free+57/64] [tcp_close+1409/1424] 
Feb  7 02:30:01 incandescent kernel:    [__free_pages+27/32] [free_pages+26/32] [release_task+295/336] [sys_wait4+899/912] [sys_ipc+64/640] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: httpd         S CF5A0000    32 25789    159         25790 25788 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sys_semop+907/1184] [net_tx_action+141/160] [do_softirq+90/176] [ip_queue_xmit2+0/523] [_text_lock_netfilter+182/219] 
Feb  7 02:30:01 incandescent kernel:    [skb_release_data+103/112] [kfree_skbmem+11/96] [tcp_recvmsg+1739/2032] [tcp_v4_destroy_sock+20/352] [sk_free+57/64] [tcp_close+1409/1424] 
Feb  7 02:30:01 incandescent kernel:    [__free_pages+27/32] [free_pages+26/32] [release_task+295/336] [sys_wait4+899/912] [sys_ipc+64/640] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: httpd         S C7B96000     0 25790    159         26038 25789 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sys_semop+907/1184] [net_tx_action+141/160] [do_softirq+90/176] [ip_queue_xmit2+0/523] [_text_lock_netfilter+182/219] 
Feb  7 02:30:01 incandescent kernel:    [skb_release_data+103/112] [kfree_skbmem+11/96] [tcp_recvmsg+1739/2032] [tcp_v4_destroy_sock+20/352] [sk_free+57/64] [tcp_close+1409/1424] 
Feb  7 02:30:01 incandescent kernel:    [__free_pages+27/32] [free_pages+26/32] [release_task+295/336] [sys_wait4+899/912] [sys_ipc+64/640] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: httpd         S CE5E2000     0 26038    159         29152 25790 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sys_semop+907/1184] [net_tx_action+141/160] [do_softirq+90/176] [ip_queue_xmit2+0/523] [_text_lock_netfilter+182/219] 
Feb  7 02:30:01 incandescent kernel:    [skb_release_data+103/112] [kfree_skbmem+11/96] [tcp_recvmsg+1739/2032] [tcp_v4_destroy_sock+20/352] [sk_free+57/64] [tcp_close+1409/1424] 
Feb  7 02:30:01 incandescent kernel:    [__free_pages+27/32] [free_pages+26/32] [release_task+295/336] [sys_wait4+899/912] [sys_ipc+64/640] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: httpd         S CDFDA000     0 29152    159         29168 26038 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sys_semop+907/1184] [net_tx_action+141/160] [do_softirq+90/176] [ip_queue_xmit2+0/523] [_text_lock_netfilter+182/219] 
Feb  7 02:30:01 incandescent kernel:    [skb_release_data+103/112] [kfree_skbmem+11/96] [tcp_recvmsg+1739/2032] [tcp_v4_destroy_sock+20/352] [sk_free+57/64] [tcp_close+1409/1424] 
Feb  7 02:30:01 incandescent kernel:    [__free_pages+27/32] [free_pages+26/32] [release_task+295/336] [sys_wait4+899/912] [sys_ipc+64/640] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: httpd         S C298E000     4 29168    159         29169 29152 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sys_semop+907/1184] [net_tx_action+141/160] [do_softirq+90/176] [ip_queue_xmit2+0/523] [_text_lock_netfilter+182/219] 
Feb  7 02:30:01 incandescent kernel:    [skb_release_data+103/112] [kfree_skbmem+11/96] [tcp_recvmsg+1739/2032] [tcp_v4_destroy_sock+20/352] [sk_free+57/64] [tcp_close+1409/1424] 
Feb  7 02:30:01 incandescent kernel:    [__free_pages+27/32] [free_pages+26/32] [release_task+295/336] [sys_wait4+899/912] [sys_ipc+64/640] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: httpd         S C298C000     0 29169    159          1968 29168 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sys_semop+907/1184] [net_tx_action+141/160] [do_softirq+90/176] [ip_queue_xmit2+0/523] [_text_lock_netfilter+182/219] 
Feb  7 02:30:01 incandescent kernel:    [skb_release_data+103/112] [kfree_skbmem+11/96] [tcp_recvmsg+1739/2032] [tcp_v4_destroy_sock+20/352] [sk_free+57/64] [tcp_close+1409/1424] 
Feb  7 02:30:01 incandescent kernel:    [__free_pages+27/32] [free_pages+26/32] [release_task+295/336] [sys_wait4+899/912] [sys_ipc+64/640] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: httpd         S CE53A000  2672  1968    159               29169 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sys_semop+907/1184] [net_tx_action+141/160] [do_softirq+90/176] [ip_queue_xmit2+0/523] [_text_lock_netfilter+182/219] 
Feb  7 02:30:01 incandescent kernel:    [skb_release_data+103/112] [kfree_skbmem+11/96] [tcp_recvmsg+1739/2032] [tcp_v4_destroy_sock+20/352] [sk_free+57/64] [tcp_close+1409/1424] 
Feb  7 02:30:01 incandescent kernel:    [__free_pages+27/32] [free_pages+26/32] [release_task+295/336] [sys_wait4+899/912] [sys_ipc+64/640] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: mutt          S CE789F28     0  9517   9884                     (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_poll+188/224] [sys_poll+477/752] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: sshd          S 7FFFFFFF   996 31886    238 31893    4730 12543 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: rsync         S CA775F2C  1268 31893  31886 31894               (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: rsync         S C81FFF2C    16 31894  31893                     (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: scp           D 00000282     0 26034      1               27389 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sleep_on+61/80] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-652601/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-652024/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-591726/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-654750/96] 
Feb  7 02:30:01 incandescent kernel:    [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-591574/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-591401/96] [__mark_inode_dirty+46/128] [update_atime+75/80] [do_generic_file_read+1117/1136] [generic_file_read+133/320] 
Feb  7 02:30:01 incandescent kernel:    [file_read_actor+0/144] [sys_read+150/208] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: ssh           S 7FFFFFFF     0  1889    313                     (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: bash          D C72569EC     0  3494  27389          3561 14718 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [__down+84/160] [__down_failed+8/12] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-559040/96] [_text_lock_readdir+5/45] [sys_getdents64+79/259] 
Feb  7 02:30:01 incandescent kernel:    [filldir64+0/368] [sys_fcntl64+128/144] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: bash          S 7FFFFFFF  4804  3561  27389                3494 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+23/160] [read_chan+941/1792] [tty_read+184/224] [sys_read+150/208] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: sshd          S 7FFFFFFF   336  4730    238  4734         31886 (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: bash          S 00000000  4804  4734   4730  5796               (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [sys_wait4+862/912] [system_call+51/56] 
Feb  7 02:30:01 incandescent kernel: vim           S 7FFFFFFF  2672  5796   4734                     (NOTLB)
Feb  7 02:30:01 incandescent kernel: Call Trace: [normal_poll+259/287] [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:46 incandescent kernel: SysRq : HELP : loglevel0-8 reBoot tErm kIll saK killalL showMem showPc unRaw Sync showTasks Unmount 
Feb  7 02:30:58 incandescent kernel: SysRq : HELP : loglevel0-8 reBoot tErm kIll saK killalL showMem showPc unRaw Sync showTasks Unmount 
Feb  7 02:30:59 incandescent kernel: SysRq : Show State
Feb  7 02:30:59 incandescent kernel: 
Feb  7 02:30:59 incandescent kernel:                          free                        sibling
Feb  7 02:30:59 incandescent kernel:   task             PC    stack   pid father child younger older
Feb  7 02:30:59 incandescent kernel: init          S CFFE7F2C  4628     1      0 26034               (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: keventd       S 00010000  5684     2      1             3       (L-TLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [context_thread+251/416] [kernel_thread+40/64] 
Feb  7 02:30:59 incandescent kernel: ksoftirqd_CPU S C1376000  5368     3      1             4     2 (L-TLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [ksoftirqd+114/176] [kernel_thread+40/64] 
Feb  7 02:30:59 incandescent kernel: kswapd        S C1375F88  5092     4      1             5     3 (L-TLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [interruptible_sleep_on_timeout+66/96] [wakeup_memwaiters+121/256] [kswapd+707/720] 
Feb  7 02:30:59 incandescent kernel:    [kernel_thread+40/64] 
Feb  7 02:30:59 incandescent kernel: bdflush       S 00000286  5436     5      1             6     4 (L-TLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [interruptible_sleep_on+61/80] [bdflush+149/160] [kernel_thread+40/64] 
Feb  7 02:30:59 incandescent kernel: kupdated      S C1371FC8  4772     6      1             7     5 (L-TLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [kupdate+130/272] [kernel_thread+40/64] 
Feb  7 02:30:59 incandescent kernel: kreiserfsd    S CFDDBFB4  5544     7      1            20     6 (L-TLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [interruptible_sleep_on_timeout+66/96] [reiserfs_journal_commit_thread+149/208] [kernel_thread+40/64] 
Feb  7 02:30:59 incandescent kernel: devfsd        S CF9D8000  5928    20      1           109     7 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [devfsd_read+248/944] [sys_read+150/208] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: eth1          S CF5B3F98     0   109      1           151    20 (L-TLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [interruptible_sleep_on_timeout+66/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-520802/96] [kernel_thread+40/64] 
Feb  7 02:30:59 incandescent kernel: kjournald     D CF47BE74     8   151      1           159   109 (L-TLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [__wait_on_buffer+106/144] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-645402/96] [schedule+704/752] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-636693/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-636992/96] 
Feb  7 02:30:59 incandescent kernel:    [kernel_thread+40/64] 
Feb  7 02:30:59 incandescent kernel: httpd         S CEFA1F2C  4560   159      1  1968     172   151 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_select+417/480] [kfree+146/160] [sys_select+810/1136] 
Feb  7 02:30:59 incandescent kernel:    [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: syslogd       S 7FFFFFFF  3896   172      1           175   159 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: klogd         R CEED8000  4828   175      1           181   172 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [do_syslog+193/736] [kmsg_read+17/32] [sys_read+150/208] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: exim          S 7FFFFFFF  2672   181      1           205   175 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: inetd         S CEF29FB0     0   205      1           208   181 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sys_rt_sigsuspend+230/256] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: ippl          S CEBE9F88   428   208      1   210     226   205 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [sys_nanosleep+278/496] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: ippl          S CEC21F28     0   210    208   211               (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_poll+188/224] [sys_poll+477/752] [end_8259A_irq+24/32] 
Feb  7 02:30:59 incandescent kernel:    [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: ippl          S 7FFFFFFF  2676   211    210                     (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+23/160] [wait_for_packet+210/320] [skb_recv_datagram+174/208] [raw_recvmsg+117/336] [inet_recvmsg+61/96] 
Feb  7 02:30:59 incandescent kernel:    [sock_recvmsg+61/192] [sock_read+142/160] [sys_read+150/208] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: oidentd       S 7FFFFFFF     0   226      1           230   208 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+23/160] [wait_for_connect+224/384] [tcp_accept+129/416] [inet_accept+48/304] [sys_accept+102/256] 
Feb  7 02:30:59 incandescent kernel:    [do_page_fault+0/1172] [sys_rt_sigaction+152/320] [sys_socketcall+179/512] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: nmbd          S CEAADF2C  4828   230      1           232   226 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: smbd          S 7FFFFFFF  5236   232      1 26861     238   230 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: sshd          S 7FFFFFFF  2672   238      1  4730     243   232 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: cron          S CE82DF88  2672   243      1           246   238 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [sys_nanosleep+278/496] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: bash          S 7FFFFFFF  2256   246      1          2055   243 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+23/160] [read_chan+941/1792] [tty_read+184/224] [sys_read+150/208] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: sshd          S 7FFFFFFF     0   308    238   313   12543       (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [normal_poll+259/287] [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: bash          S 00000000     0   313    308  1889               (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sys_wait4+862/912] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: smbd          S C8C15F2C    16 26858    232         26859       (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: smbd          S C9145F2C  3536 26859    232         26861 26858 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: smbd          S CA687F2C     0 26861    232               26859 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: screen        S 7FFFFFFF  2672  2055      1  9884   27389   246 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: bash          S 00000000   660  2056   2055  7457    2772       (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sys_wait4+862/912] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: screen        S 7FFFFFFF   584 27389      1  3561   26034  2055 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [normal_poll+259/287] [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: bash          S 00000000  2672 27391  27389 14574   14718       (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sys_wait4+862/912] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: bash          S 00000000  5444  2772   2055  3065    3239  2056 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sys_wait4+862/912] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: ssh           S 7FFFFFFF     0  3065   2772                     (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: bash          S 7FFFFFFF     0  3239   2055          3964  2772 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+23/160] [read_chan+941/1792] [tty_read+184/224] [sys_read+150/208] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: bash          S 00000000   660  3964   2055  5543    9884  3239 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sys_wait4+862/912] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: lftp          S C0BF1F28  2144  5543   3964                     (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_poll+188/224] [sys_poll+477/752] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: mutt          S CDC5DF28  2676  7457   2056                     (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_poll+188/224] [sys_poll+477/752] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: bash          S 00000000  2676  9884   2055  9517          3964 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sys_wait4+862/912] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: sshd          S 7FFFFFFF     0 12543    238 12556    4730   308 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: bash          S 00000000     0 12556  12543 12590               (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sys_wait4+862/912] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: screen        S C8A08000   660 12590  12556                     (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sys_pause+18/24] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: ncftp         D 00000282     0 14574  27391                     (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sleep_on+61/80] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-652601/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-652024/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-591726/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-654750/96] 
Feb  7 02:30:59 incandescent kernel:    [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-591574/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-591401/96] [__mark_inode_dirty+46/128] [generic_file_write+816/1872] [sock_read+142/160] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-607978/96] 
Feb  7 02:30:59 incandescent kernel:    [sys_write+150/208] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: bash          D C0079EB0     0 14718  27389          3494 27391 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [__wait_on_buffer+106/144] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-599850/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-608890/96] [do_page_fault+355/1172] [do_page_fault+0/1172] 
Feb  7 02:30:59 incandescent kernel:    [vfs_readdir+97/144] [filldir64+0/368] [sys_getdents64+79/259] [filldir64+0/368] [sys_fcntl64+128/144] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: httpd         S 7FFFFFFF    16 25786    159         25787       (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: httpd         S C801A000     0 25787    159         25788 25786 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sys_semop+907/1184] [net_tx_action+141/160] [do_softirq+90/176] [ip_queue_xmit2+0/523] [_text_lock_netfilter+182/219] 
Feb  7 02:30:59 incandescent kernel:    [skb_release_data+103/112] [kfree_skbmem+11/96] [tcp_recvmsg+1739/2032] [tcp_v4_destroy_sock+20/352] [sk_free+57/64] [tcp_close+1409/1424] 
Feb  7 02:30:59 incandescent kernel:    [__free_pages+27/32] [free_pages+26/32] [release_task+295/336] [sys_wait4+899/912] [sys_ipc+64/640] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: httpd         S C2112000     0 25788    159         25789 25787 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sys_semop+907/1184] [net_tx_action+141/160] [do_softirq+90/176] [ip_queue_xmit2+0/523] [_text_lock_netfilter+182/219] 
Feb  7 02:30:59 incandescent kernel:    [skb_release_data+103/112] [kfree_skbmem+11/96] [tcp_recvmsg+1739/2032] [tcp_v4_destroy_sock+20/352] [sk_free+57/64] [tcp_close+1409/1424] 
Feb  7 02:30:59 incandescent kernel:    [__free_pages+27/32] [free_pages+26/32] [release_task+295/336] [sys_wait4+899/912] [sys_ipc+64/640] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: httpd         S CF5A0000    32 25789    159         25790 25788 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sys_semop+907/1184] [net_tx_action+141/160] [do_softirq+90/176] [ip_queue_xmit2+0/523] [_text_lock_netfilter+182/219] 
Feb  7 02:30:59 incandescent kernel:    [skb_release_data+103/112] [kfree_skbmem+11/96] [tcp_recvmsg+1739/2032] [tcp_v4_destroy_sock+20/352] [sk_free+57/64] [tcp_close+1409/1424] 
Feb  7 02:30:59 incandescent kernel:    [__free_pages+27/32] [free_pages+26/32] [release_task+295/336] [sys_wait4+899/912] [sys_ipc+64/640] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: httpd         S C7B96000     0 25790    159         26038 25789 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sys_semop+907/1184] [net_tx_action+141/160] [do_softirq+90/176] [ip_queue_xmit2+0/523] [_text_lock_netfilter+182/219] 
Feb  7 02:30:59 incandescent kernel:    [skb_release_data+103/112] [kfree_skbmem+11/96] [tcp_recvmsg+1739/2032] [tcp_v4_destroy_sock+20/352] [sk_free+57/64] [tcp_close+1409/1424] 
Feb  7 02:30:59 incandescent kernel:    [__free_pages+27/32] [free_pages+26/32] [release_task+295/336] [sys_wait4+899/912] [sys_ipc+64/640] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: httpd         S CE5E2000     0 26038    159         29152 25790 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sys_semop+907/1184] [net_tx_action+141/160] [do_softirq+90/176] [ip_queue_xmit2+0/523] [_text_lock_netfilter+182/219] 
Feb  7 02:30:59 incandescent kernel:    [skb_release_data+103/112] [kfree_skbmem+11/96] [tcp_recvmsg+1739/2032] [tcp_v4_destroy_sock+20/352] [sk_free+57/64] [tcp_close+1409/1424] 
Feb  7 02:30:59 incandescent kernel:    [__free_pages+27/32] [free_pages+26/32] [release_task+295/336] [sys_wait4+899/912] [sys_ipc+64/640] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: httpd         S CDFDA000     0 29152    159         29168 26038 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sys_semop+907/1184] [net_tx_action+141/160] [do_softirq+90/176] [ip_queue_xmit2+0/523] [_text_lock_netfilter+182/219] 
Feb  7 02:30:59 incandescent kernel:    [skb_release_data+103/112] [kfree_skbmem+11/96] [tcp_recvmsg+1739/2032] [tcp_v4_destroy_sock+20/352] [sk_free+57/64] [tcp_close+1409/1424] 
Feb  7 02:30:59 incandescent kernel:    [__free_pages+27/32] [free_pages+26/32] [release_task+295/336] [sys_wait4+899/912] [sys_ipc+64/640] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: httpd         S C298E000     4 29168    159         29169 29152 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sys_semop+907/1184] [net_tx_action+141/160] [do_softirq+90/176] [ip_queue_xmit2+0/523] [_text_lock_netfilter+182/219] 
Feb  7 02:30:59 incandescent kernel:    [skb_release_data+103/112] [kfree_skbmem+11/96] [tcp_recvmsg+1739/2032] [tcp_v4_destroy_sock+20/352] [sk_free+57/64] [tcp_close+1409/1424] 
Feb  7 02:30:59 incandescent kernel:    [__free_pages+27/32] [free_pages+26/32] [release_task+295/336] [sys_wait4+899/912] [sys_ipc+64/640] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: httpd         S C298C000     0 29169    159          1968 29168 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sys_semop+907/1184] [net_tx_action+141/160] [do_softirq+90/176] [ip_queue_xmit2+0/523] [_text_lock_netfilter+182/219] 
Feb  7 02:30:59 incandescent kernel:    [skb_release_data+103/112] [kfree_skbmem+11/96] [tcp_recvmsg+1739/2032] [tcp_v4_destroy_sock+20/352] [sk_free+57/64] [tcp_close+1409/1424] 
Feb  7 02:30:59 incandescent kernel:    [__free_pages+27/32] [free_pages+26/32] [release_task+295/336] [sys_wait4+899/912] [sys_ipc+64/640] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: httpd         S CE53A000  2672  1968    159               29169 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sys_semop+907/1184] [net_tx_action+141/160] [do_softirq+90/176] [ip_queue_xmit2+0/523] [_text_lock_netfilter+182/219] 
Feb  7 02:30:59 incandescent kernel:    [skb_release_data+103/112] [kfree_skbmem+11/96] [tcp_recvmsg+1739/2032] [tcp_v4_destroy_sock+20/352] [sk_free+57/64] [tcp_close+1409/1424] 
Feb  7 02:30:59 incandescent kernel:    [__free_pages+27/32] [free_pages+26/32] [release_task+295/336] [sys_wait4+899/912] [sys_ipc+64/640] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: mutt          S CE789F28     0  9517   9884                     (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+122/160] [process_timeout+0/80] [do_poll+188/224] [sys_poll+477/752] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: scp           D 00000282     0 26034      1               27389 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sleep_on+61/80] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-652601/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-652024/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-591726/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-654750/96] 
Feb  7 02:30:59 incandescent kernel:    [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-591574/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-591401/96] [__mark_inode_dirty+46/128] [update_atime+75/80] [do_generic_file_read+1117/1136] [generic_file_read+133/320] 
Feb  7 02:30:59 incandescent kernel:    [file_read_actor+0/144] [sys_read+150/208] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: ssh           S 7FFFFFFF     0  1889    313                     (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: bash          D C72569EC     0  3494  27389          3561 14718 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [__down+84/160] [__down_failed+8/12] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-559040/96] [_text_lock_readdir+5/45] [sys_getdents64+79/259] 
Feb  7 02:30:59 incandescent kernel:    [filldir64+0/368] [sys_fcntl64+128/144] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: bash          S 7FFFFFFF  4804  3561  27389                3494 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+23/160] [read_chan+941/1792] [tty_read+184/224] [sys_read+150/208] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: sshd          S 7FFFFFFF   336  4730    238  4734         12543 (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: bash          S 00000000  4804  4734   4730  5796               (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [sys_wait4+862/912] [system_call+51/56] 
Feb  7 02:30:59 incandescent kernel: vim           S 7FFFFFFF  2672  5796   4734                     (NOTLB)
Feb  7 02:30:59 incandescent kernel: Call Trace: [normal_poll+259/287] [schedule_timeout+23/160] [do_select+417/480] [sys_select+810/1136] [system_call+51/56] 

On Thu, Feb 07, 2002 at 01:23:14AM -0800, Andrew Morton wrote:
[...]
> 
> You should check for any odd messages from the device driver
> or LVM layers, if the logs made it to disk.
> 
> -
> 
> 

-- 
"I think a lot of the basis of the open source movement comes from
  procrastinating students..."
	-- Andrew Tridgell <http://www.linux-mag.com/2001-07/tridgell_04.html>
