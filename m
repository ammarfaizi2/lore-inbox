Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291614AbSBAJAN>; Fri, 1 Feb 2002 04:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291613AbSBAI7y>; Fri, 1 Feb 2002 03:59:54 -0500
Received: from chello062179036163.chello.pl ([62.179.36.163]:26385 "EHLO
	pioneer") by vger.kernel.org with ESMTP id <S291612AbSBAI7l>;
	Fri, 1 Feb 2002 03:59:41 -0500
Date: Fri, 1 Feb 2002 10:02:39 +0100 (CET)
From: Tomasz Rola <rtomek@cis.com.pl>
To: Anish Srivastava <anish@bidorbuyindia.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Java for Linux
In-Reply-To: <005201c1aae9$2215cb00$3c00a8c0@baazee.com>
Message-ID: <Pine.LNX.3.96.1020201093634.1961A-100000@pioneer>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 1 Feb 2002, Anish Srivastava wrote:

> Can anyone guide me in choosing the appropriate port of Java for Linux
> 2.4.17 and glibc-2.2.2-10
> Which is the best of the three?
> Blackdown Java
> IBM JAVA
> Sun Java
> 
> I have heard that Blackdown supports native threads...while IBM and SUN do
> not!!
> Any kind of help will be greatly appreciated.....

I had some headaches with native threads in the past but now it seems to
be ok. The problem was with some nontrivial programs, like accessing
database and showing some dynamic info about this process at the same
time (using awt). Worked very good with green threads (not native). So
anything you try, pay attention to version numbers. I think one can tell
the difference between native and green when running on multiple cpus. It
doesn't matter whether one uses threads in the application, since java
runtime starts few threads of its own (garbage collector, display refresh
etc). So overall you should feel jvm with native threads runs faster on
multiple cpus while there shouldn't be much difference on a sigle cpu. I
am not sure how fast it can be on multiple cpus because I have never tried
it. There are some issues like thread synchronisation, that can slow it
down however. So everything depends on what java program you want to run
(and how you design/write it).

As a side note, I am using java on Linux for more than 4 years now and it
is very good and stable, at least the Blackdown port. I have less
experience with IBM and Sun's but you should be ok with any of them. There
is also kaffe vm available at www.kaffe.org. It implements older apis but
there is source code for it which may be helpful sometimes. And, recently,
I have heard of wonca vm (wonca.acunia.com, source available too) but
haven't tried it yet. If you are interested in something different, check
waba vm at http://sourceforge.net/projects/waba (non standard, very
small, opensource).

> If this mailing list id not the right place for the above question....can
> anyone guide me to an appropriate mailing list

I suppose this is not the right place. The only list I know about is
debian-java. Have a look at http://www.debian.org/MailingLists/subscribe,
there should be a link to archives somewhere too.

Hope this helps.

bye
T.

- --
** A C programmer asked whether computer had Buddha's nature.      **
** As the answer, master did "rm -rif" on the programmer's home    **
** directory. And then the C programmer became enlightened...      **
**                                                                 **
** Tomasz Rola          mailto:tomasz_rola@bigfoot.com             **

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
Charset: noconv

iQA/AwUBPFpZtRETUsyL9vbiEQKPpACdGfWa1N3vhHtEzJvEl5tj4gJ3HgUAoKBd
IEDOH+GmZSe9AiF5oy4z3UDg
=YROU
-----END PGP SIGNATURE-----

