Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276040AbRJBRaF>; Tue, 2 Oct 2001 13:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276047AbRJBR34>; Tue, 2 Oct 2001 13:29:56 -0400
Received: from cloven-ext.nks.net ([216.139.204.130]:52253 "EHLO
	homer.mkintl.com") by vger.kernel.org with ESMTP id <S276040AbRJBR3q>;
	Tue, 2 Oct 2001 13:29:46 -0400
Message-ID: <3BB9F9A1.3030803@illusionary.com>
Date: Tue, 02 Oct 2001 13:30:09 -0400
From: Derek Glidden <dglidden@illusionary.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: strange kapm-idled behaviour
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(this is *not* a "why does kapm-ideld take up all my CPU time" question!)

I've noticed that on occasion, often when Java-based programs but not 
necessarily always, kapm-idled stops running, even when something like 
gkrellm or xosview doesn't show any CPU activity and when "w" shows zero 
load on the machine.

That in itself isn't too odd, but if, when kapm-idled gets in one of 
these weird states, I do 'ps' or run 'top', the kapm-idled thread will 
all of a sudden "come to life" and start running, but it will frequently 
"give up" and go completely idle after periods of other CPU activity.

I've tried to narrow down the conditions when kapm-idled starts acting 
like this, but the best I've come up with is "usually when I run a Java 
app, but not always, and sometimes when nothing out of the ordinary 
seems to be going on."

Usually when this strange behaviour is happening, doing a 'ps' shows 
that the kapm-idled thread is in 'SW' state.

I'm seeing this with the 2.4.10 kernel.  I don't remember noticing it 
with 2.4.9 or anything else previous.  I have SGI's XFS patches applied, 
but otherwise a stock kernel.

This is obviously not a critical issue, it's just strange.

Please CC me directly on any replies if anyone would like further 
information.

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

