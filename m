Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287321AbRL3DiV>; Sat, 29 Dec 2001 22:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287322AbRL3DiL>; Sat, 29 Dec 2001 22:38:11 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:29459 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287321AbRL3Dhx>;
	Sat, 29 Dec 2001 22:37:53 -0500
Date: Sun, 30 Dec 2001 01:30:33 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Kernel Janitor Project 
	<kernel-janitor-discuss@lists.sourceforge.net>
Subject: [ANNOUNCE] include dependency graph script
Message-ID: <20011230013033.A2856@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Janitor Project <kernel-janitor-discuss@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	For the people that like me, Daniel Phillips and Manfred Spraul are
working on pruning the include dependencies in the kernel sources I made a
simple script to make a graphviz file to plot the dependencies in a nice
graphic, its availabe at:

http://www.kernel.org/pub/linux/kernel/people/acme/hviz

usage:

hviz include/net/sock.h 2 | dotty -

or

hviz include/net/sock.h 2 > /tmp/sock.dot
dot -Tps /tmp/sock.dot > /tmp/sock.ps
gv /tmp/sock.ps

Yes, one can do that with pipes and not with the temporary sock.dot file,
but this is just so that you can see how the intermediate graphviz file
look like.

this example is also available at:

http://www.kernel.org/pub/linux/kernel/people/acme/sock_include_deps.ps

So that people can see how it looks :-)

the graphviz package is available at:
http://www.research.att.com/sw/tools/graphviz/

Comments and patches for the script are welcome.

- Arnaldo
