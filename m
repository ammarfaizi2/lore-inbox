Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279631AbRKATvQ>; Thu, 1 Nov 2001 14:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279638AbRKATvG>; Thu, 1 Nov 2001 14:51:06 -0500
Received: from hoju-ext.nks.net ([216.139.204.180]:24448 "EHLO
	hoju-ext.nks.net") by vger.kernel.org with ESMTP id <S279631AbRKATuq>;
	Thu, 1 Nov 2001 14:50:46 -0500
Message-ID: <3BE1A790.25B7E6F5@illusionary.com>
Date: Thu, 01 Nov 2001 14:50:40 -0500
From: Derek Glidden <dglidden@illusionary.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.2 and 2.4 VM systems analysed
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been following the 2.4 VM issues since the early 2.4-pre days.  As
a "power user" and someone who uses Linux at work, the kernel's
stability is of great interest to me.  Finally, I got sick of trying to
interpret the data from various sources on how well the 2.4 VM systems
perform overall and in comparison with each other and other systems.  So
I ran my own tests against 2.4.12-ac6, 2.4.13, and 2.2.19 and wrote up
the results:

"An analysis of three Linux kernel VM systems"

http://www.nks.net/linux-vm.html

The conclusion in a nutshell is that yes, the 2.4 kernel VM systems
still have a few quirks to work out, but overall they are so
significantly better than the 2.2 VM that there really is no
comparison.  

However, this "significantly better" conclusion is for certain
high-stress situations where the 2.2 VM apparently fails entirely, while
2.4 chugs along with barely a notice.  

For overall end-user experience, 2.2 still "feels" better overall with
better interactive responsiveness under a varying set of loads even
though 2.4 really is faster at doing the actual work.

Comments, responses, suggestions welcome.  Flames will be cheerfully
redirected to /dev/null.

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
   http://www.sciencemag.org/cgi/content/full/293/5537/2028
