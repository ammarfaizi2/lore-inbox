Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130109AbQLNEgM>; Wed, 13 Dec 2000 23:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130340AbQLNEgC>; Wed, 13 Dec 2000 23:36:02 -0500
Received: from adsl-216-102-162-162.dsl.snfc21.pacbell.net ([216.102.162.162]:41223
	"EHLO janus") by vger.kernel.org with ESMTP id <S130109AbQLNEfv>;
	Wed, 13 Dec 2000 23:35:51 -0500
X-Face: +.[`xCMz]E6GW}5ECgY#C"Er6&v$q7:oe+zPlPtOh>/US;9B>;)ro_lpLx9/]q_{u-\YR>rP&)Da0gS,PW{@BWSG,PIV)3#J<$Ft_t]qa!xF~'*wuwg-CJj*0:EUr3z}y
Date: Wed, 13 Dec 2000 20:05:16 -800
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
X-Originating-IP: [63.167.149.130]
Subject: Re: [PATCH] bsd-style cursor
Content-Transfer-Encoding: 7BIT
In-Reply-To: <6313347DCD663344A7658E90E56201C209B1A9@2kmail.calific.com>
From: Markus Gutschke <markus@gutschke.com>
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E146Pdu-0006kB-00@janus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennert Buytenhek wrote:
> On Wed, 13 Dec 2000, James Simmons wrote: 
> > How about placing 
> >  echo '\033[?17;120c' 
> > In one of your startup scripts. This will give you this nice BSD 
> > cursor you like. 
> 
> [ buytenh@mara buytenh]$ tail -1 ~/.bash_profile 
> echo -e -n '\033[?17;127c' 
> [buytenh@mara buytenh]$ 
> 
> This has Issues though: try entering vi for example. 

My /etc/inittab has lines that look like this:

  1:2345:respawn:/sbin/getty 38400 tty1 -I '^[c^[[?17;55;248c'

This gives me a nice red non-blinking cursor. No problems with vi
whatsoever. Of course, this only works on the console, but for my
terminal windows, I can set these values in resource or configuration
files. So, all of this is a user-space problem. No need to complicate
the kernel code.


Markus

-- 
Markus Gutschke                                Resonate, Inc.
3637 Fillmore Street #106                      385 Moffett Park Drive
San Francisco, CA 94123-1600                   Sunnyvale, CA 94089
+1-415-567-8449                                +1-408-548-5528
markus@gutschke.com                            mgutschk@resonate.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
