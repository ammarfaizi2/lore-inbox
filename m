Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136473AbRAZS7H>; Fri, 26 Jan 2001 13:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136444AbRAZS6t>; Fri, 26 Jan 2001 13:58:49 -0500
Received: from esteel10.client.dti.net ([209.73.14.10]:42798 "EHLO
	nynews01.e-steel.com") by vger.kernel.org with ESMTP
	id <S136473AbRAZS6d>; Fri, 26 Jan 2001 13:58:33 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
Newsgroups: e-steel.mailing-lists.linux.linux-kernel
Subject: network problem (not ECN)
Date: 26 Jan 2001 13:58:26 -0500
Organization: e-STEEL Netops news server
Message-ID: <m3k87ita25.fsf@shookay.e-steel.com>
NNTP-Posting-Host: shookay.e-steel
X-Trace: nynews01.e-steel.com 980535413 20563 192.168.3.43 (26 Jan 2001 18:56:53 GMT)
X-Complaints-To: news@nynews01.e-steel.com
NNTP-Posting-Date: 26 Jan 2001 18:56:53 GMT
X-Newsreader: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi everybody!

I've seen that the discussion with the ECN thing is quiet interesting and
I'm experiencing something strange when I try to ftp to
ftp.kernel.org. That's what I get:
NcFTP 3.0.1 (March 27, 2000) by Mike Gleason (ncftp@ncftp.com).

ncftp> open ftp.kernel.org 
Connecting to 209.10.41.242...                                                  
ProFTPD 1.2.0 Server (ProFTPD) [zeus.kernel.org]
Logging in...                                                                   
                            Welcome to the
 
                        LINUX KERNEL ARCHIVES
                            ftp.kernel.org

Remote host has closed the connection.                                          
Logged in to ftp.kernel.org.                                                    
ncftp> 

I've attached the tcpdump output for this session. If anyone is able to
explain that to me...

Thanks!

User level filter, protocol ALL, TURBO mode (575 frames), datagram packet socket
tcpdump: listening on all devices
13:51:15.483800 eth0 > myname.mydomain.com.47029 > zeus.kernel.org.ftp: S 4270986830:4270986830(0) win 5840 <mss 1460,sackOK,timestamp 16037859 0,nop,wscale 0> (DF) (ttl 64, id 0)
13:51:15.573976 eth0 < zeus.kernel.org.ftp > myname.mydomain.com.47029: S 4266783476:4266783476(0) ack 4270986831 win 32120 <mss 1460,sackOK,timestamp 794396911 16037859,nop,wscale 0> (DF) (ttl 51, id 1348)
13:51:15.573998 eth0 > myname.mydomain.com.47029 > zeus.kernel.org.ftp: . 1:1(0) ack 1 win 5840 <nop,nop,timestamp 16037868 794396911> (DF) (ttl 64, id 0)
13:51:25.661937 eth0 < zeus.kernel.org.ftp > myname.mydomain.com.47029: P 1:55(54) ack 1 win 32120 <nop,nop,timestamp 794397920 16037868> (DF) (ttl 51, id 18753)
13:51:25.661988 eth0 > myname.mydomain.com.47029 > zeus.kernel.org.ftp: . 1:1(0) ack 55 win 5840 <nop,nop,timestamp 16038877 794397920> (DF) (ttl 64, id 0)
13:51:25.662327 eth0 > myname.mydomain.com.47029 > zeus.kernel.org.ftp: P 1:17(16) ack 55 win 5840 <nop,nop,timestamp 16038877 794397920> (DF) (ttl 64, id 0)
13:51:25.750853 eth0 < zeus.kernel.org.ftp > myname.mydomain.com.47029: . 55:55(0) ack 17 win 32120 <nop,nop,timestamp 794397928 16038877> (DF) (ttl 51, id 18942)
13:51:25.769999 eth0 < zeus.kernel.org.ftp > myname.mydomain.com.47029: P 55:127(72) ack 17 win 32120 <nop,nop,timestamp 794397930 16038877> (DF) (ttl 51, id 18979)
13:51:25.770210 eth0 > myname.mydomain.com.47029 > zeus.kernel.org.ftp: P 17:52(35) ack 127 win 5840 <nop,nop,timestamp 16038888 794397930> (DF) (ttl 64, id 0)
13:51:25.871311 eth0 < zeus.kernel.org.ftp > myname.mydomain.com.47029: . 127:127(0) ack 52 win 32120 <nop,nop,timestamp 794397941 16038888> (DF) (ttl 51, id 19168)
13:51:25.873171 eth0 < zeus.kernel.org.ftp > myname.mydomain.com.47029: P 127:154(27) ack 52 win 32120 <nop,nop,timestamp 794397941 16038888> (DF) (ttl 51, id 19169)
13:51:25.873580 eth0 < zeus.kernel.org.ftp > myname.mydomain.com.47029: P 154:157(3) ack 52 win 32120 <nop,nop,timestamp 794397941 16038888> (DF) (ttl 51, id 19170)
13:51:25.874052 eth0 < zeus.kernel.org.ftp > myname.mydomain.com.47029: P 157:184(27) ack 52 win 32120 <nop,nop,timestamp 794397941 16038888> (DF) (ttl 51, id 19171)
13:51:25.874497 eth0 < zeus.kernel.org.ftp > myname.mydomain.com.47029: P 184:208(24) ack 52 win 32120 <nop,nop,timestamp 794397941 16038888> (DF) (ttl 51, id 19172)
13:51:25.908647 eth0 > myname.mydomain.com.47029 > zeus.kernel.org.ftp: . 52:52(0) ack 208 win 5840 <nop,nop,timestamp 16038902 794397941> (DF) (ttl 64, id 0)
13:51:26.009354 eth0 < zeus.kernel.org.ftp > myname.mydomain.com.47029: P 1656:2066(410) ack 52 win 32120 <nop,nop,timestamp 794397953 16038902> (DF) (ttl 51, id 19408)
13:51:26.009396 eth0 > myname.mydomain.com.47029 > zeus.kernel.org.ftp: . 52:52(0) ack 208 win 5840 <nop,nop,timestamp 16038912 794397941,nop,nop, sack 1 {1656:2066} > (DF) (ttl 64, id 0)
13:51:26.097802 eth0 < zeus.kernel.org.ftp > myname.mydomain.com.47029: R 4266783684:4266783684(0) win 0 (ttl 242, id 19596)

9252 packets received by filter

-- 
Mathieu CHOUQUET-STRINGER              E-Mail : mchouque@e-steel.com
     Learning French is trivial: the word for horse is cheval, and
               everything else follows in the same way.
                        -- Alan J. Perlis
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
