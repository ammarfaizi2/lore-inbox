Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbSA2VUZ>; Tue, 29 Jan 2002 16:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279798AbSA2VUQ>; Tue, 29 Jan 2002 16:20:16 -0500
Received: from natwar.webmailer.de ([192.67.198.70]:52362 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S274862AbSA2VUK>; Tue, 29 Jan 2002 16:20:10 -0500
Date: Tue, 29 Jan 2002 22:15:45 +0100
From: Kristian <kristian.peters@korseby.net>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18pre7-ac1
Message-Id: <20020129221545.4e9a253e.kristian.peters@korseby.net>
In-Reply-To: <200201291712.g0THCIn31150@devserv.devel.redhat.com>
In-Reply-To: <200201291712.g0THCIn31150@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.7.0claws5 (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Compiling fails with the following output:

ld: cannot open ipt_ah.o: No such file or directory
make[3]: *** [netfilter.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.18-pre7-ac1/net/ipv4/netfilter'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.18-pre7-ac1/net/ipv4/netfilter'
make[1]: *** [_subdir_ipv4/netfilter] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.18-pre7-ac1/net'
make: *** [_dir_net] Error 2

This is related to CONFIG_IP_NF_MATCH_AH_ESP. Switching it off will not reveal this error (because there's no file called ipt_ah.c).

Same with option CONFIG_IP_NF_TARGET_ULOG.

I read this before on the list, but found no answer.

Maybe that was meant with
> several 18pre7 netfilter bugs left unfixed for now

Thanks,
 *Kristian

  :... [snd.science] ...:
 ::
 :: http://www.korseby.net
 :: http://gsmp.sf.net
  :.........................:: ~/$ kristian@korseby.net :
