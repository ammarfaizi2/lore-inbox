Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281668AbRK2S7F>; Thu, 29 Nov 2001 13:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280320AbRK2S64>; Thu, 29 Nov 2001 13:58:56 -0500
Received: from hoju-ext.nks.net ([216.139.204.180]:41611 "EHLO
	hoju-ext.nks.net") by vger.kernel.org with ESMTP id <S281668AbRK2S6p>;
	Thu, 29 Nov 2001 13:58:45 -0500
Message-ID: <3C06855F.22AD79C4@illusionary.com>
Date: Thu, 29 Nov 2001 13:58:39 -0500
From: Derek Glidden <dglidden@illusionary.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kapm-idled no longer idling CPU?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I posted this question about a month ago, but haven't seen a response
since, so I'm reposting.

I'm having a problem with all recent 2.4 systems that when any
application that uses more than very minor system resources is running,
(i.e. mozilla, netscape, xemacs, apache, Tomcat, just to name a few
common ones I've seen this behaviour with) kapm-idled no longer receives
scheduling time from what I can tell and I assume that means my CPU is
never getting idled when nothing is scheduled.

I'm pretty sure this is a legit problem and not just kapm-idled
reporting its time incorrectly since my laptop has gone from about 2-1/2
hours of battery life in early 2.4 versions to less than 1 hour of
battery life under the same conditions for recent kernels.  Plus, if I
exit everything until I'm just sitting at a shell prompt, I'll see
kapm-idled start to receive time again.  (Of course, the laptop isn't
much fun when it's not running anything...)

I've seen this on a number of laptops and desktop machines since about
2.4.9 or so.

-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#!/usr/bin/perl -w
$_='while(read+STDIN,$_,2048){$a=29;$b=73;$c=142;$t=255;@t=map
{$_%16or$t^=$c^=($m=(11,10,116,100,11,122,20,100)[$_/16%8])&110;
$t^=(72,@z=(64,72,$a^=12*($_%16-2?0:$m&17)),$b^=$_%64?12:0,@z)
[$_%8]}(16..271);if((@a=unx"C*",$_)[20]&48){$h=5;$_=unxb24,join
"",@b=map{xB8,unxb8,chr($_^$a[--$h+84])}@ARGV;s/...$/1$&/;$d=
unxV,xb25,$_;$e=256|(ord$b[4])<<9|ord$b[3];$d=$d>>8^($f=$t&($d
>>12^$d>>4^$d^$d/8))<<17,$e=$e>>8^($t&($g=($q=$e>>14&7^$e)^$q*
8^$q<<6))<<9,$_=$t[$_]^(($h>>=8)+=$f+(~$g&$t))for@a[128..$#a]}
print+x"C*",@a}';s/x/pack+/g;eval 

usage: qrpff 153 2 8 105 225 < /mnt/dvd/VOB_FILENAME \
    | extract_mpeg2 | mpeg2dec - 

         http://www.cs.cmu.edu/~dst/DeCSS/Gallery/
http://www.eff.org/                   http://www.anti-dmca.org/
