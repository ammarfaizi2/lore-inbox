Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129374AbRBAJ6P>; Thu, 1 Feb 2001 04:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129392AbRBAJ6F>; Thu, 1 Feb 2001 04:58:05 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:6957 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S129374AbRBAJ5z>; Thu, 1 Feb 2001 04:57:55 -0500
Date: Thu, 1 Feb 2001 10:57:36 +0100
From: Rainer Wiener <rainer@konqui.de>
To: LA Walsh <law@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: seti@home and es1371
Message-ID: <20010201105736.A8112@mulder.konqui.de>
In-Reply-To: <20010131171130.A1664@mulder.konqui.de> <3A786758.E607E63D@sgi.com> <20010201101346.C4014@mulder.konqui.de> <3A792A49.CDE8FBE0@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A792A49.CDE8FBE0@sgi.com>; from law@sgi.com on Thu, Feb 01, 2001 at 01:20:09AM -0800
X-GPG-Fingerprint: 8F30 218F 1353 F984 1242  6FD3 3569 E885 C53E 61DA
X-Operating-System: Debian GNU/Linux Sid (Linux 2.4.1)
X-Homepage: http://www.konqui.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Feb 2001, LA Walsh wrote:

> Now that's just plain weird.  Doesn't sound like a cpu thing.  Hmmm.  Have your
> run "vmstat 5" - is there disk activity when the sound drops?  How about 'top'
> does it show anything interesting?  You could try upping the priority of freeamp, but
> that would just be a hack...the nicing of set to 19 should have done the trick.
> Hmmmm...

This is what vmstat 5 give out. When I play mp3 with xmms for 1 min.:

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0     12   5848   3316  75912   0   0     2     2  198   430  99   1   1
 2  0  0     12   5920   3320  75924   0   0     1    18  517  1731  97   3   0
 1  0  0     12   4640   3320  76176   0   0    13     1  227   868 100   0   0
 3  0  0     12   4512   3320  76304   0   0     6     0  236   910 100   0   0
 1  0  0     12   5536   3320  76304   0   0     0     6  238   909  99   1   0
 1  0  0     12   4380   3320  76432   0   0     6     0  238   870  99   1   0
 1  0  0     12   5280   3320  76560   0   0     6     0  227   839 100   0   0
 1  0  0     12   4764   3320  76560   0   0     0     1  225   822  99   1   0
 1  0  0     12   5152   3320  76688   0   0     6     0  236   860 100   0   0
 1  0  0     12   4124   3320  76688   0   0     0     0  225   828 100   0   0
 1  0  0     12   5024   3320  76816   0   0     6     0  226   852  99   1   0
 1  0  0     12   3868   3320  76944   0   0     6     6  239   904  99   1   0
 1  0  0     12   4764   3320  76944   0   0     0     0  445  1591  97   3   0

Set nice higher bei xmms do not help.

This is the output form top:



 10:56am  up 12:52,  7 users,  load average: 1.00, 1.05, 1.07
98 processes: 96 sleeping, 2 running, 0 zombie, 0 stopped
CPU states:   1.2% user,   0.6% system,  97.6% nice,   0.6% idle
Mem:    255736K total,   251904K used,     3832K free,     3520K buffers
Swap:   128484K total,       12K used,   128472K free,    75800K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  384 rainer    20  19 14768  14M   932 R N  95.1  5.7 756:06 setiathome
 9145 rainer    14   0  1064 1064   824 R     4.7  0.4   0:00 top
 9141 rainer     9   0  8532 8532  4668 S     0.9  3.3   0:00 xmms
    1 root       8   0   528  528   460 S     0.0  0.2   0:05 init
    2 root       9   0     0    0     0 SW    0.0  0.0   0:00 keventd
    3 root       9   0     0    0     0 SW    0.0  0.0   0:00 kapm-idled
    4 root       9   0     0    0     0 SW    0.0  0.0   0:00 kswapd
    5 root       9   0     0    0     0 SW    0.0  0.0   0:00 kreclaimd
    6 root       9   0     0    0     0 SW    0.0  0.0   0:00 bdflush
    7 root       9   0     0    0     0 SW    0.0  0.0   0:00 kupdate
  105 daemon     9   0   480  480   396 S     0.0  0.1   0:00 portmap
  173 root       9   0   768  768   636 S     0.0  0.3   0:00 syslogd
  175 root       9   0  1152 1152   464 S     0.0  0.4   0:00 klogd
  181 root       8   0   524  524   456 S     0.0  0.2   0:00 apmd
  193 root       9   0   500  500   428 S     0.0  0.1   0:00 gpm
  198 root       8   0   672  672   580 S     0.0  0.2   0:00 inetd
  206 root       9   0   720  720   608 S     0.0  0.2   0:00 lpd
  214 root       9   0  1192 1192   992 S     0.0  0.4   0:00 sshd
  218 root       9   0  3424 3424   656 S     0.0  1.3   0:00 xfs
  221 daemon     9   0   612  612   524 S     0.0  0.2   0:00 atd
  224 root       8   0   708  708   584 S     0.0  0.2   0:00 cron
  229 root       9   0  1408 1408  1316 S     0.0  0.5   0:00 apache
  232 root       9   0   492  492   424 S     0.0  0.1   0:00 getty
  234 root       9   0   492  492   424 S     0.0  0.1   0:00 getty
  235 root       9   0   492  492   424 S     0.0  0.1   0:00 getty
  236 root       9   0   492  492   424 S     0.0  0.1   0:00 getty
  237 root       9   0   492  492   424 S     0.0  0.1   0:00 getty
  240 www-data   9   0  1412 1412  1328 S     0.0  0.5   0:00 apache
  241 www-data   9   0  1412 1412  1328 S     0.0  0.5   0:00 apache
  242 www-data   9   0  1412 1412  1328 S     0.0  0.5   0:00 apache
  243 www-data   9   0  1412 1412  1328 S     0.0  0.5   0:00 apache
  244 www-data   9   0  1412 1412  1328 S     0.0  0.5   0:00 apache
  271 root       9   0  1648 1648  1268 S     0.0  0.6   0:00 Login.app
  272 root       5 -10  132M  20M  4768 S <   0.0  8.1   2:16 X
  274 root       9   0   492  492   424 S     0.0  0.1   0:00 getty
  292 root       9   0  1808 1808  1432 S     0.0  0.7   0:00 xconsole
  295 rainer     9   0  3248 3248  2004 S     0.0  1.2   0:13 WindowMaker
  329 rainer     9   0   884  884   716 S     0.0  0.3   0:00 ssh-agent
  336 rainer     9   0  2392 2392  1900 S     0.0  0.9   0:00 wmxmms
  337 rainer     9   0   884  884   752 S     0.0  0.3   0:00 asclock
  338 rainer     9   0  1456 1456  1240 S     0.0  0.5   0:13 WMMail
  339 rainer     9   0   936  936   772 S     0.0  0.3   0:00 wmmon
  340 rainer     9   0   848  848   744 S     0.0  0.3   0:00 wmnet
  341 rainer     9   0  1392 1392  1052 S     0.0  0.5   0:00 wmpinboard
  342 rainer     9   0   972  972   812 S     0.0  0.3   0:00 wmWeather
  366 rainer     9   0  6140 6140  4480 S     0.0  2.4   0:03 xchat
  393 rainer     9   0  1208 1204   928 S     0.0  0.4   0:00 run-mozilla.sh
  398 rainer     9   0 38960  38M 15232 S     0.0 15.2   4:47 mozilla-bin
  400 rainer     8   0 38960  38M 15232 S     0.0 15.2   0:00 mozilla-bin
  401 rainer     9   0 38960  38M 15232 S     0.0 15.2   0:00 mozilla-bin
  403 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:01 java_vm
  404 rainer     8   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  405 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  406 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  407 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  408 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  409 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  410 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  411 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  412 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  413 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  414 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  415 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  416 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  417 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  418 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  577 mailhole   9   0  1668 1668  1328 S     0.0  0.6   0:00 fetchmail
  794 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
 3979 rainer     9   0  6004 6004  4884 S     0.0  2.3   0:00 licq
 3980 rainer     8   0  6004 6004  4884 S     0.0  2.3   0:00 licq
 3981 rainer     9   0  6004 6004  4884 S     0.0  2.3   0:00 licq
 3982 rainer     9   0  6004 6004  4884 S     0.0  2.3   0:00 licq
 3983 rainer     9   0  6004 6004  4884 S     0.0  2.3   0:01 licq
 4003 rainer     9   0  1460 1460  1148 S     0.0  0.5   0:00 aterm
 4004 rainer     9   0  1452 1452  1108 S     0.0  0.5   0:00 bash
 8112 rainer     9   0  1656 1656  1264 S     0.0  0.6   0:00 mutt
 8153 rainer     9   0 38960  38M 15232 S     0.0 15.2   0:00 mozilla-bin
 8316 rainer     9   0  1460 1460  1148 S     0.0  0.5   0:00 aterm
 8317 rainer     9   0  1448 1448  1104 S     0.0  0.5   0:00 bash
 8318 rainer     9   0  2636 2636  1224 S     0.0  1.0   0:00 mutt
 8324 rainer     9   0  1456 1456  1148 S     0.0  0.5   0:00 aterm
 8325 rainer     9   0  1452 1452  1108 S     0.0  0.5   0:00 bash
 8326 rainer     8   0  1584 1584  1208 S     0.0  0.6   0:00 mutt
 8618 rainer     9   0  1460 1460  1148 S     0.0  0.5   0:00 aterm
 8619 rainer     9   0  1448 1448  1104 S     0.0  0.5   0:00 bash
 8620 rainer     9   0  1664 1664  1272 S     0.0  0.6   0:00 mutt
 8893 rainer     9   0  1808 1804  1088 S     0.0  0.7   0:00 jed
 8909 rainer     9   0  1456 1456  1148 S     0.0  0.5   0:00 aterm
 8910 rainer     8   0  1456 1456  1112 S     0.0  0.5   0:00 bash
 8922 rainer     9   0  1468 1468  1148 S     0.0  0.5   0:00 aterm
 8923 rainer     9   0  1472 1472  1120 S     0.0  0.5   0:00 bash
 8947 rainer     9   0  1476 1476  1148 S     0.0  0.5   0:00 aterm
 8948 rainer     9   0  1628 1628  1188 S     0.0  0.6   0:00 bash
 8965 rainer     9   0  8532 8532  4668 S     0.0  3.3   0:00 xmms
 8966 rainer     9   0  8532 8532  4668 S     0.0  3.3   0:00 xmms
 8967 rainer     9   0  8532 8532  4668 S     0.0  3.3   0:00 xmms
 8970 rainer     9   0  8532 8532  4668 S     0.0  3.3   0:00 xmms
 9140 rainer     9   0  8532 8532  4668 S     0.0  3.3   0:00 xmms

 10:56am  up 12:52,  7 users,  load average: 1.00, 1.05, 1.07
98 processes: 93 sleeping, 5 running, 0 zombie, 0 stopped
CPU states:   1.0% user,   1.6% system,  97.4% nice,   0.0% idle
Mem:    255736K total,   252428K used,     3308K free,     3520K buffers
Swap:   128484K total,       12K used,   128472K free,    75808K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  384 rainer    20  19 15284  14M   932 R N  98.0  5.9 756:11 setiathome
 9145 rainer    14   0  1064 1064   824 R     1.1  0.4   0:00 top
  398 rainer     9   0 38960  38M 15232 R     0.3 15.2   4:47 mozilla-bin
 9141 rainer     9   0  8532 8532  4668 S     0.3  3.3   0:00 xmms
    1 root       8   0   528  528   460 S     0.0  0.2   0:05 init
    2 root       9   0     0    0     0 SW    0.0  0.0   0:00 keventd
    3 root       9   0     0    0     0 SW    0.0  0.0   0:00 kapm-idled
    4 root       9   0     0    0     0 SW    0.0  0.0   0:00 kswapd
    5 root       9   0     0    0     0 SW    0.0  0.0   0:00 kreclaimd
    6 root       9   0     0    0     0 SW    0.0  0.0   0:00 bdflush
    7 root       9   0     0    0     0 SW    0.0  0.0   0:00 kupdate
  105 daemon     9   0   480  480   396 S     0.0  0.1   0:00 portmap
  173 root       9   0   768  768   636 S     0.0  0.3   0:00 syslogd
  175 root       9   0  1152 1152   464 S     0.0  0.4   0:00 klogd
  181 root       8   0   524  524   456 S     0.0  0.2   0:00 apmd
  193 root       9   0   500  500   428 S     0.0  0.1   0:00 gpm
  198 root       8   0   672  672   580 S     0.0  0.2   0:00 inetd
  206 root       9   0   720  720   608 S     0.0  0.2   0:00 lpd
  214 root       9   0  1192 1192   992 S     0.0  0.4   0:00 sshd
  218 root       9   0  3424 3424   656 S     0.0  1.3   0:00 xfs
  221 daemon     9   0   612  612   524 S     0.0  0.2   0:00 atd
  224 root       8   0   708  708   584 S     0.0  0.2   0:00 cron
  229 root       9   0  1408 1408  1316 S     0.0  0.5   0:00 apache
  232 root       9   0   492  492   424 S     0.0  0.1   0:00 getty
  234 root       9   0   492  492   424 S     0.0  0.1   0:00 getty
  235 root       9   0   492  492   424 S     0.0  0.1   0:00 getty
  236 root       9   0   492  492   424 S     0.0  0.1   0:00 getty
  237 root       9   0   492  492   424 S     0.0  0.1   0:00 getty
  240 www-data   9   0  1412 1412  1328 S     0.0  0.5   0:00 apache
  241 www-data   9   0  1412 1412  1328 S     0.0  0.5   0:00 apache
  242 www-data   9   0  1412 1412  1328 S     0.0  0.5   0:00 apache
  243 www-data   9   0  1412 1412  1328 S     0.0  0.5   0:00 apache
  244 www-data   9   0  1412 1412  1328 S     0.0  0.5   0:00 apache
  271 root       9   0  1648 1648  1268 S     0.0  0.6   0:00 Login.app
  272 root       5 -10  132M  20M  4768 S <   0.0  8.1   2:16 X
  274 root       9   0   492  492   424 S     0.0  0.1   0:00 getty
  292 root       9   0  1808 1808  1432 S     0.0  0.7   0:00 xconsole
  295 rainer     9   0  3248 3248  2004 S     0.0  1.2   0:13 WindowMaker
  329 rainer     9   0   884  884   716 S     0.0  0.3   0:00 ssh-agent
  336 rainer     9   0  2392 2392  1900 S     0.0  0.9   0:00 wmxmms
  337 rainer     9   0   884  884   752 S     0.0  0.3   0:00 asclock
  338 rainer     9   0  1456 1456  1240 S     0.0  0.5   0:13 WMMail
  339 rainer     9   0   936  936   772 S     0.0  0.3   0:00 wmmon
  340 rainer     9   0   848  848   744 S     0.0  0.3   0:00 wmnet
  341 rainer     9   0  1392 1392  1052 S     0.0  0.5   0:00 wmpinboard
  342 rainer     9   0   972  972   812 R     0.0  0.3   0:00 wmWeather
  366 rainer     9   0  6140 6140  4480 S     0.0  2.4   0:03 xchat
  393 rainer     9   0  1208 1204   928 S     0.0  0.4   0:00 run-mozilla.sh
  400 rainer     8   0 38960  38M 15232 R     0.0 15.2   0:00 mozilla-bin
  401 rainer     9   0 38960  38M 15232 S     0.0 15.2   0:00 mozilla-bin
  403 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:01 java_vm
  404 rainer     8   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  405 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  406 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  407 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  408 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  409 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  410 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  411 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  412 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  413 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  414 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  415 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  416 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  417 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  418 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  577 mailhole   9   0  1668 1668  1328 S     0.0  0.6   0:00 fetchmail
  794 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
 3979 rainer     9   0  6004 6004  4884 S     0.0  2.3   0:00 licq
 3980 rainer     8   0  6004 6004  4884 S     0.0  2.3   0:00 licq
 3981 rainer     9   0  6004 6004  4884 S     0.0  2.3   0:00 licq
 3982 rainer     9   0  6004 6004  4884 S     0.0  2.3   0:00 licq
 3983 rainer     9   0  6004 6004  4884 S     0.0  2.3   0:01 licq
 4003 rainer     9   0  1460 1460  1148 S     0.0  0.5   0:00 aterm
 4004 rainer     9   0  1452 1452  1108 S     0.0  0.5   0:00 bash
 8112 rainer     9   0  1656 1656  1264 S     0.0  0.6   0:00 mutt
 8153 rainer     9   0 38960  38M 15232 S     0.0 15.2   0:00 mozilla-bin
 8316 rainer     9   0  1460 1460  1148 S     0.0  0.5   0:00 aterm
 8317 rainer     9   0  1448 1448  1104 S     0.0  0.5   0:00 bash
 8318 rainer     9   0  2636 2636  1224 S     0.0  1.0   0:00 mutt
 8324 rainer     9   0  1456 1456  1148 S     0.0  0.5   0:00 aterm
 8325 rainer     9   0  1452 1452  1108 S     0.0  0.5   0:00 bash
 8326 rainer     8   0  1584 1584  1208 S     0.0  0.6   0:00 mutt
 8618 rainer     9   0  1460 1460  1148 S     0.0  0.5   0:00 aterm
 8619 rainer     9   0  1448 1448  1104 S     0.0  0.5   0:00 bash
 8620 rainer     9   0  1664 1664  1272 S     0.0  0.6   0:00 mutt
 8893 rainer     9   0  1808 1804  1088 S     0.0  0.7   0:00 jed
 8909 rainer     9   0  1456 1456  1148 S     0.0  0.5   0:00 aterm
 8910 rainer     8   0  1456 1456  1112 S     0.0  0.5   0:00 bash
 8922 rainer     9   0  1468 1468  1148 S     0.0  0.5   0:00 aterm
 8923 rainer     9   0  1472 1472  1120 S     0.0  0.5   0:00 bash
 8947 rainer     9   0  1476 1476  1148 S     0.0  0.5   0:00 aterm
 8948 rainer     9   0  1628 1628  1188 S     0.0  0.6   0:00 bash
 8965 rainer     9   0  8532 8532  4668 S     0.0  3.3   0:00 xmms
 8966 rainer     9   0  8532 8532  4668 S     0.0  3.3   0:00 xmms
 8967 rainer     9   0  8532 8532  4668 S     0.0  3.3   0:00 xmms
 8970 rainer     9   0  8532 8532  4668 S     0.0  3.3   0:00 xmms
 9140 rainer     9   0  8532 8532  4668 S     0.0  3.3   0:00 xmms

 10:56am  up 12:53,  7 users,  load average: 1.00, 1.05, 1.07
98 processes: 95 sleeping, 3 running, 0 zombie, 0 stopped
CPU states:   0.6% user,   1.2% system,  98.2% nice,   0.0% idle
Mem:    255736K total,   252948K used,     2788K free,     3520K buffers
Swap:   128484K total,       12K used,   128472K free,    75816K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  384 rainer    20  19 15796  15M   932 R N  98.4  6.1 756:16 setiathome
 9145 rainer    14   0  1064 1064   824 R     1.1  0.4   0:00 top
  272 root       5 -10  132M  20M  4768 S <   0.1  8.1   2:16 X
 9141 rainer     9   0  8532 8532  4668 S     0.1  3.3   0:00 xmms
    1 root       8   0   528  528   460 S     0.0  0.2   0:05 init
    2 root       9   0     0    0     0 SW    0.0  0.0   0:00 keventd
    3 root       9   0     0    0     0 SW    0.0  0.0   0:00 kapm-idled
    4 root       9   0     0    0     0 SW    0.0  0.0   0:00 kswapd
    5 root       9   0     0    0     0 SW    0.0  0.0   0:00 kreclaimd
    6 root       9   0     0    0     0 SW    0.0  0.0   0:00 bdflush
    7 root       9   0     0    0     0 SW    0.0  0.0   0:00 kupdate
  105 daemon     9   0   480  480   396 S     0.0  0.1   0:00 portmap
  173 root       9   0   768  768   636 S     0.0  0.3   0:00 syslogd
  175 root       9   0  1152 1152   464 S     0.0  0.4   0:00 klogd
  181 root       8   0   524  524   456 S     0.0  0.2   0:00 apmd
  193 root       9   0   500  500   428 S     0.0  0.1   0:00 gpm
  198 root       8   0   672  672   580 S     0.0  0.2   0:00 inetd
  206 root       9   0   720  720   608 S     0.0  0.2   0:00 lpd
  214 root       9   0  1192 1192   992 S     0.0  0.4   0:00 sshd
  218 root       9   0  3424 3424   656 S     0.0  1.3   0:00 xfs
  221 daemon     9   0   612  612   524 S     0.0  0.2   0:00 atd
  224 root       8   0   708  708   584 S     0.0  0.2   0:00 cron
  229 root       9   0  1408 1408  1316 S     0.0  0.5   0:00 apache
  232 root       9   0   492  492   424 S     0.0  0.1   0:00 getty
  234 root       9   0   492  492   424 S     0.0  0.1   0:00 getty
  235 root       9   0   492  492   424 S     0.0  0.1   0:00 getty
  236 root       9   0   492  492   424 S     0.0  0.1   0:00 getty
  237 root       9   0   492  492   424 S     0.0  0.1   0:00 getty
  240 www-data   9   0  1412 1412  1328 S     0.0  0.5   0:00 apache
  241 www-data   9   0  1412 1412  1328 S     0.0  0.5   0:00 apache
  242 www-data   9   0  1412 1412  1328 S     0.0  0.5   0:00 apache
  243 www-data   9   0  1412 1412  1328 S     0.0  0.5   0:00 apache
  244 www-data   9   0  1412 1412  1328 S     0.0  0.5   0:00 apache
  271 root       9   0  1648 1648  1268 S     0.0  0.6   0:00 Login.app
  274 root       9   0   492  492   424 S     0.0  0.1   0:00 getty
  292 root       9   0  1808 1808  1432 S     0.0  0.7   0:00 xconsole
  295 rainer     9   0  3248 3248  2004 S     0.0  1.2   0:13 WindowMaker
  329 rainer     9   0   884  884   716 S     0.0  0.3   0:00 ssh-agent
  336 rainer     9   0  2392 2392  1900 S     0.0  0.9   0:00 wmxmms
  337 rainer     9   0   884  884   752 S     0.0  0.3   0:00 asclock
  338 rainer     9   0  1456 1456  1240 S     0.0  0.5   0:13 WMMail
  339 rainer     9   0   936  936   772 S     0.0  0.3   0:00 wmmon
  340 rainer     9   0   848  848   744 S     0.0  0.3   0:00 wmnet
  341 rainer     9   0  1392 1392  1052 S     0.0  0.5   0:00 wmpinboard
  342 rainer     9   0   972  972   812 R     0.0  0.3   0:00 wmWeather
  366 rainer     9   0  6140 6140  4480 S     0.0  2.4   0:03 xchat
  393 rainer     9   0  1208 1204   928 S     0.0  0.4   0:00 run-mozilla.sh
  398 rainer     9   0 38960  38M 15232 S     0.0 15.2   4:47 mozilla-bin
  400 rainer     8   0 38960  38M 15232 S     0.0 15.2   0:00 mozilla-bin
  401 rainer     9   0 38960  38M 15232 S     0.0 15.2   0:00 mozilla-bin
  403 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:01 java_vm
  404 rainer     8   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  405 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  406 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  407 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  408 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  409 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  410 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  411 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  412 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  413 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  414 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  415 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  416 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  417 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  418 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
  577 mailhole   9   0  1668 1668  1328 S     0.0  0.6   0:00 fetchmail
  794 rainer     9   0 19900  19M  5180 S     0.0  7.7   0:00 java_vm
 3979 rainer     9   0  6004 6004  4884 S     0.0  2.3   0:00 licq
 3980 rainer     8   0  6004 6004  4884 S     0.0  2.3   0:00 licq
 3981 rainer     9   0  6004 6004  4884 S     0.0  2.3   0:00 licq
 3982 rainer     9   0  6004 6004  4884 S     0.0  2.3   0:00 licq
 3983 rainer     9   0  6004 6004  4884 S     0.0  2.3   0:01 licq
 4003 rainer     9   0  1460 1460  1148 S     0.0  0.5   0:00 aterm
 4004 rainer     9   0  1452 1452  1108 S     0.0  0.5   0:00 bash
 8112 rainer     9   0  1656 1656  1264 S     0.0  0.6   0:00 mutt
 8153 rainer     9   0 38960  38M 15232 S     0.0 15.2   0:00 mozilla-bin
 8316 rainer     9   0  1460 1460  1148 S     0.0  0.5   0:00 aterm
 8317 rainer     9   0  1448 1448  1104 S     0.0  0.5   0:00 bash
 8318 rainer     9   0  2636 2636  1224 S     0.0  1.0   0:00 mutt
 8324 rainer     9   0  1456 1456  1148 S     0.0  0.5   0:00 aterm
 8325 rainer     9   0  1452 1452  1108 S     0.0  0.5   0:00 bash
 8326 rainer     8   0  1584 1584  1208 S     0.0  0.6   0:00 mutt
 8618 rainer     9   0  1460 1460  1148 S     0.0  0.5   0:00 aterm
 8619 rainer     9   0  1448 1448  1104 S     0.0  0.5   0:00 bash
 8620 rainer     9   0  1664 1664  1272 S     0.0  0.6   0:00 mutt
 8893 rainer     9   0  1808 1804  1088 S     0.0  0.7   0:00 jed
 8909 rainer     9   0  1456 1456  1148 S     0.0  0.5   0:00 aterm
 8910 rainer     8   0  1456 1456  1112 S     0.0  0.5   0:00 bash
 8922 rainer     9   0  1468 1468  1148 S     0.0  0.5   0:00 aterm
 8923 rainer     9   0  1472 1472  1120 S     0.0  0.5   0:00 bash
 8947 rainer     9   0  1476 1476  1148 S     0.0  0.5   0:00 aterm
 8948 rainer     9   0  1628 1628  1188 S     0.0  0.6   0:00 bash
 8965 rainer     9   0  8532 8532  4668 S     0.0  3.3   0:00 xmms
 8966 rainer     9   0  8532 8532  4668 S     0.0  3.3   0:00 xmms
 8967 rainer     9   0  8532 8532  4668 S     0.0  3.3   0:00 xmms
 8970 rainer     9   0  8532 8532  4668 S     0.0  3.3   0:00 xmms
 9140 rainer     9   0  8532 8532  4668 S     0.0  3.3   0:00 xmms



cu
Rainer
-- 
You will be married within a year, and divorced within two.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
