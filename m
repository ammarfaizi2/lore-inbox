Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291900AbSBIA3k>; Fri, 8 Feb 2002 19:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291894AbSBIA3g>; Fri, 8 Feb 2002 19:29:36 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:6916
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S291900AbSBIA3J>; Fri, 8 Feb 2002 19:29:09 -0500
Date: Fri, 8 Feb 2002 19:30:17 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
cc: akpm@zip.com.au, <riel@surriel.com>
Subject: 2.4.18-pre9+2.4.18-pre7-ac3 + XFS + rmap12d - elvtune/vmstat info 
Message-ID: <Pine.LNX.4.40.0202081925590.431-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


<riel> ShawnXFS: that's some _very_ interesting info
<riel> ShawnXFS: could you mail that to linux-kernel, me and akpm@zip.com.au ? ;)

from free:

<ShawnXFS>              total       used       free     shared    buffers     cached
<ShawnXFS> Mem:         61996      61188        808          0          0      36888
<ShawnXFS> -/+ buffers/cache:      24300      37696
<ShawnXFS> Swap:       182276      47068     135208

(after mozilla was closed).

>From elvtune:

elvtune /dev/hdb

/dev/hdb elevator ID            1
        read_latency:           8192
        write_latency:          16384
        max_bomb_segments:      6

elvtune /dev/hda

/dev/hda elevator ID            0
        read_latency:           8192
        write_latency:          16384
        max_bomb_segments:      256 <-- was originally 6 but changed to 256.

   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us
sy  id
 1  0  0  37152   1296      0  38388  42  91   136    97  191   192  29
3  68

(currently) with system doing nothing much.

