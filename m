Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263344AbRFFOma>; Wed, 6 Jun 2001 10:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbRFFOmU>; Wed, 6 Jun 2001 10:42:20 -0400
Received: from cloven-ext.nks.net ([216.139.204.130]:7959 "EHLO
	homer.mkintl.com") by vger.kernel.org with ESMTP id <S263344AbRFFOmB>;
	Wed, 6 Jun 2001 10:42:01 -0400
Message-ID: <3B1E4131.83F76073@illusionary.com>
Date: Wed, 06 Jun 2001 10:41:53 -0400
From: Derek Glidden <dglidden@illusionary.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Xavier Bestel <xavier.bestel@free.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com>
		<Pine.LNX.4.33.0106051634540.8311-100000@heat.gghcwest.com>
		<3B1D927E.1B2EBE76@uow.edu.au>  <20010605231908.A10520@illusionary.com> <991815578.30689.1.camel@nomade>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel wrote:
> 
> Did you try to put twice as much swap as you have RAM ? (e.g. add a 512M
> swapfile to your box)
> This is what Linus recommended for 2.4 (swap = 2 * RAM), saying that
> anything less won't do any good: 2.4 overallocates swap even if it
> doesn't use it all. So in your case you just have enough swap to map
> your RAM, and nothing to really swap your apps.

Yes, the example given is against the machine at work, which is
configured 512/512.  My machine at home is configured 512/1024 and has
the same problems.  Further, this machine *used* to have only 256MB of
RAM, and I could still cause the misbehaviour.

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

http://www.eff.org/                    http://www.opendvd.org/ 
         http://www.cs.cmu.edu/~dst/DeCSS/Gallery/
