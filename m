Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269583AbUJSScI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269583AbUJSScI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 14:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269668AbUJSS1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:27:53 -0400
Received: from knorkaan.xs4all.nl ([213.84.240.34]:3853 "EHLO
	knorkaan.xs4all.nl") by vger.kernel.org with ESMTP id S269570AbUJSSVa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 14:21:30 -0400
Date: Tue, 19 Oct 2004 20:21:24 +0200 (CEST)
From: Jerome Borsboom <j.borsboom@erasmusmc.nl>
To: linux-kernel@vger.kernel.org
Subject: process start time set wrongly at boot for kernel 2.6.9
Message-ID: <Pine.LNX.4.61.0410192015420.6471@knorkaan.xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with kernel 2.6.9 the process start time is set wrongly for 
processes that get started early in the boot process. Below is a dump from 
my 'ps' command. Note the start time for processes 1-12. After process 12 
the start time is set right.

Jerome


USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.1  1372  500 ?        S    20:59   0:00 init [3] 
root         2  0.0  0.0     0    0 ?        SN   20:59   0:00 [ksoftirqd/0]
root         3  0.0  0.0     0    0 ?        S<   20:59   0:00 [events/0]
root         4  0.0  0.0     0    0 ?        S<   20:59   0:00 [khelper]
root         5  0.0  0.0     0    0 ?        S<   20:59   0:00 [kblockd/0]
root         6  0.0  0.0     0    0 ?        S    20:59   0:00 [pdflush]
root         7  0.0  0.0     0    0 ?        S    20:59   0:00 [pdflush]
root         9  0.0  0.0     0    0 ?        S<   20:59   0:00 [aio/0]
root         8  0.0  0.0     0    0 ?        S    20:59   0:00 [kswapd0]
root        10  0.0  0.0     0    0 ?        S    20:59   0:00 [kseriod]
root        11  0.0  0.0     0    0 ?        S    20:59   0:00 [scsi_eh_0]
root        12  0.0  0.0     0    0 ?        S    20:59   0:00 [ahc_dv_0]
root        13  0.0  0.0     0    0 ?        S    19:48   0:00 [scsi_eh_1]
root        14  0.0  0.0     0    0 ?        S    19:48   0:00 [ahc_dv_1]
root        15  0.0  0.0     0    0 ?        S    19:48   0:00 [scsi_eh_2]
root        16  0.0  0.0     0    0 ?        S    19:48   0:00 [ahc_dv_2]
root        17  0.0  0.0     0    0 ?        S    19:49   0:00 [kjournald]
root        43  0.0  0.0     0    0 ?        S    19:49   0:00 [kjournald]
root        44  0.0  0.0     0    0 ?        S    19:49   0:00 [kjournald]
root        45  0.0  0.0     0    0 ?        S    19:49   0:00 [kjournald]
root        46  0.0  0.0     0    0 ?        S    19:49   0:00 [kjournald]
root        47  0.0  0.0     0    0 ?        S    19:49   0:00 [kjournald]
root        48  0.0  0.0     0    0 ?        S    19:49   0:00 [kjournald]
root       122  0.0  0.2  1420  552 ?        Ss   19:49   0:00 /sbin/syslogd -m 0
root       124  0.0  0.1  1376  452 ?        Ss   19:49   0:00 /sbin/klogd
root       131  0.0  0.3  1640  776 ?        Ss   19:49   0:00 /sbin/apcupsd
root       139  0.0  0.9  2444 2444 ?        SLs  19:49   0:00 /usr/bin/ntpd
ldap       148  0.0  1.8 50084 4696 ?        Ssl  19:49   0:00 /usr/sbin/slapd -4 -u ldap -h ldap:/// ldapi:///
nscd       153  0.0  0.6 10208 1640 ?        Ssl  19:49   0:00 /usr/sbin/nscd
root       162  0.0  0.5  3156 1392 ?        Ss   19:49   0:00 /usr/sbin/sshd
root       168  0.0  0.9  5396 2436 ?        Ss   19:49   0:00 sendmail: accepting connections 
smmsp      173  0.0  0.8  5176 2144 ?        Ss   19:49   0:00 sendmail: Queue runner@01:00:00 for /var/spool/clientmqueue
root       177  0.0  0.2  1372  564 ?        Ss   19:49   0:00 /usr/sbin/cron
