Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286895AbSBRVEc>; Mon, 18 Feb 2002 16:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286263AbSBRVEX>; Mon, 18 Feb 2002 16:04:23 -0500
Received: from dinadan.u-strasbg.fr ([130.79.74.10]:18080 "EHLO
	dinadan.u-strasbg.fr") by vger.kernel.org with ESMTP
	id <S286895AbSBRVEO>; Mon, 18 Feb 2002 16:04:14 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [bug+patch] negative inode number in /proc/net/udp
In-Reply-To: <87g03yq0ph.fsf@dinadan.u-strasbg.fr>
From: Arnaud Giersch <giersch@icps.u-strasbg.fr>
Organization: ICPS
X-Face: &yL?ZRfSIk3zaRm*dlb3R4f.8RM"~b/h|\wI]>pL)}]l$H>.Q3Qd3[<h!`K6mI=+cWpg-El
 B(FEm\EEdLdS{2l7,8\!RQ5aL0ZXlzzPKLxV/OQfrg/<t!FG>i.K[5isyT&2oBNdnvk`~y}vwPYL;R
 y)NYo"]T8NlX{nmIUEi\a$hozWm#0GCT'e'{5f@Rl"[g|I8<{By=R8R>bDe>W7)S0-8:b;ZKo~9K?'
 wq!G,MQ\eSt8g`)jeITEuig89NGmN^%1j>!*F8~kW(yfF7W[:bl>RT[`w3x-C
Date: 18 Feb 2002 22:04:12 +0100
In-Reply-To: <87g03yq0ph.fsf@dinadan.u-strasbg.fr>
Message-ID: <87664upkmr.fsf@dinadan.u-strasbg.fr>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is the same problem with unix sockets.

--- linux.orig/net/unix/af_unix.c       Fri Dec 21 18:42:06 2001
+++ linux/net/unix/af_unix.c    Mon Feb 18 22:01:29 2002
@@ -1742,7 +1742,7 @@
        {
                unix_state_rlock(s);
 
-               len+=sprintf(buffer+len,"%p: %08X %08X %08X %04X %02X %5ld",
+               len+=sprintf(buffer+len,"%p: %08X %08X %08X %04X %02X %5lu",
                        s,
                        atomic_read(&s->refcnt),
                        0,

-- 
Arnaud
