Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbTBAAEB>; Fri, 31 Jan 2003 19:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbTBAAEB>; Fri, 31 Jan 2003 19:04:01 -0500
Received: from mail018.syd.optusnet.com.au ([210.49.20.176]:1686 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S263544AbTBAAEA> convert rfc822-to-8bit; Fri, 31 Jan 2003 19:04:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] ext3, reiser, jfs, xfs effect on contest
Date: Sat, 1 Feb 2003 11:12:48 +1100
User-Agent: KMail/1.4.3
References: <200302010020.34119.conman@kolivas.net>
In-Reply-To: <200302010020.34119.conman@kolivas.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302011113.23700.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 01 Feb 2003 12:20 am, Con Kolivas wrote:
> Using the osdl hardware (http://www.osdl.org) with contest
> (http://contest.kolivas.net) I've conducted a set of benchmarks with
> different filesystems. Note that contest does not claim to be a throughput
> benchmark.

Ok to complete the picture here is the set of results including dbench_load 
and ext2.

ctar_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2559ext2        3       92      85.9    2       4.3     1.18
2559ext3        2       96      82.3    2       5.2     1.23
2559jfs         2       103     73.8    0       0.0     1.32
2559reiser      2       100     78.0    0       1.0     1.27
2559xfs         2       97      82.5    2       5.2     1.23
xtar_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2559ext2        3       92      82.6    1       3.3     1.18
2559ext3        2       97      79.4    2       6.2     1.24
2559jfs         2       136     55.9    0       0.0     1.74
2559reiser      2       104     75.0    0       4.8     1.32
2559xfs         2       105     72.4    1       7.6     1.33
io_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2559ext2        3       105     71.4    5       6.6     1.35
2559ext3        3       109     68.8    4       10.1    1.40
2559jfs         3       138     54.3    11      13.8    1.77
2559reiser      3       98      76.5    2       9.2     1.24
2559xfs         3       124     60.5    6       8.0     1.57
read_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2559ext2        3       96      81.2    6       6.2     1.23
2559ext3        2       98      80.6    7       7.1     1.26
2559jfs         2       97      79.4    5       5.2     1.24
2559reiser      2       101     79.2    6       7.9     1.28
2559xfs         2       98      80.6    6       7.1     1.24
dbench_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2559ext2        3       102     72.5    3       17.6    1.31
2559ext3        3       115     65.2    3       24.3    1.47
2559jfs         3       123     61.8    3       19.5    1.58
2559reiser      3       108     69.4    3       13.9    1.37
2559xfs         3       118     63.6    3       22.0    1.49
io_other:
Kernel     [runs]	Time    CPU%    Loads   LCPU%   Ratio
2559ext2        3   	90      83.3    3       4.4     1.14
2559ext3        3   	89      84.3    2       5.5     1.13
2559reiser      3   	87      86.2    2       5.7     1.10
2559jfs         3   	87      86.2    3       5.7     1.10
2559xfs         3   	87      86.2    2       4.5     1.10

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+OxEEF6dfvkL3i1gRAsnrAJ0YZ4FYDLA6iA0R37ccJGdIoqIcJwCeJVbu
vs0QdsTDhfti32WI5c9NJHc=
=qN8n
-----END PGP SIGNATURE-----
