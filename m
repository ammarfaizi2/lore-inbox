Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264027AbRFFSry>; Wed, 6 Jun 2001 14:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264049AbRFFSro>; Wed, 6 Jun 2001 14:47:44 -0400
Received: from cloven-ext.nks.net ([216.139.204.130]:43790 "EHLO
	homer.mkintl.com") by vger.kernel.org with ESMTP id <S264027AbRFFSrb>;
	Wed, 6 Jun 2001 14:47:31 -0400
Message-ID: <3B1E7ABA.EECCBFE0@illusionary.com>
Date: Wed, 06 Jun 2001 14:47:22 -0400
From: Derek Glidden <dglidden@illusionary.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1E4CD0.D16F58A8@illusionary.com>
		<3b204fe5.4014698@mail.mbay.net> <3B1E5316.F4B10172@illusionary.com> <m1wv6p5uqp.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> > Or are you saying that if someone is unhappy with a particular
> > situation, they should just keep their mouth shut and accept it?
> 
> It's worth complaining about.  It is also worth digging into and find
> out what the real problem is.  I have a hunch that this hole
> conversation on swap sizes being irritating is hiding the real
> problem.

I totally agree with this, and want to reiterate that the original
problem I posted has /nothing/ to do with the "swap == 2*RAM" issue.

The problem I reported is not that 2.4 uses huge amounts of swap but
that trying to recover that swap off of disk under 2.4 can leave the
machine in an entirely unresponsive state, while 2.2 handles identical
situations gracefully.  

I'm annoyed by 2.4's "requirement" of too much swap, but I consider that
less a bug and more a severe design flaw.  

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
