Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267603AbSLNL5l>; Sat, 14 Dec 2002 06:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267604AbSLNL5l>; Sat, 14 Dec 2002 06:57:41 -0500
Received: from 205-158-62-132.outblaze.com ([205.158.62.132]:39103 "HELO
	ws5-2.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S267603AbSLNL5k>; Sat, 14 Dec 2002 06:57:40 -0500
Message-ID: <20021214120526.6020.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: greg@ulima.unil.ch, rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Date: Sat, 14 Dec 2002 20:05:26 +0800
Subject: Re: Not able to compile modutils-2.4.21-7.src.rpm
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rusty Russell <rusty@rustcorp.com.au>
[...]
> > /usr/bin/ld: cannot find -lc
> > collect2: ld returned 1 exit status
> > make[1]: *** [insmod.static] Error 1
> > make[1]: Leaving directory `/usr/src/RPM/BUILD/modutils-2.4.21/insmod'
> > make: *** [all] Error 2
> > error: Bad exit status from /var/tmp/rpm-tmp.76637 (%build)
>
>It looks like you don't have the ability to make static binaries.
>Does this fail for you, too?
>
>	echo 'int main(){return 0;}' > /tmp/foo.c && gcc -static -o foo foo.c
>
>Perhaps there is some RH devel package you need to install to allow
>this to work?

Yes, you are correct and I am a stupid guy ;-)
Gregoire told me what the package is,
glibc-static-devel...

Ok, now rpm --rebuild --target i686 blabla.src.rpm
works perfectly.

No problem with modules, thank you very much!

             Paolo

From: Gregoire Favre <greg@ulima.unil.ch>
[...]
> > /usr/bin/ld: cannot find -lc
> > collect2: ld returned 1 exit status
> > make[1]: *** [insmod.static] Error 1
> 
> Just install glibc-static-devel...

Ahh... you are correct! Now it compiles,
sorry for the silly report and thank you!

               Paolo
-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
