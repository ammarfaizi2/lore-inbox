Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267266AbTAPUnK>; Thu, 16 Jan 2003 15:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267270AbTAPUnK>; Thu, 16 Jan 2003 15:43:10 -0500
Received: from homer.nks.net ([66.152.21.172]:65284 "EHLO homer.nks.net")
	by vger.kernel.org with ESMTP id <S267266AbTAPUnH>;
	Thu, 16 Jan 2003 15:43:07 -0500
Subject: 2.4.20-aa1 breaks integrit
From: Derek Glidden <dglidden@illusionary.com>
To: linux-kernel@vger.kernel.org
Cc: integrit-devel@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Jan 2003 15:51:36 -0500
Message-Id: <1042750297.26999.10.camel@two.nks.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


integrit is a filesystem checksumming tool:

http://integrit.sourceforge.net/

something in 2.4.20-aa1 breaks its ability to correctly determine
whether a file has been changed or not.  _every_ file will turn up "new"
on subsequent runs of integrit, even if nothing about that file has
changed.

2.4.19-aa1 worked correctly.

2.4.20 "plain" works correctly.

I apologize for the vagueness of this report. I know that -aa are
collections of patches from other places and I have no idea which piece
may be breaking integrit, nor any real idea what the underlying problem
really is.

And no idea who to specifically contact, either, since I don't really
know where the breakage is occurring.  :-P

Please reply directly for more info if needed.

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

