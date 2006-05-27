Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751764AbWE0CNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbWE0CNV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 22:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWE0CNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 22:13:21 -0400
Received: from quechua.inka.de ([193.197.184.2]:40646 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751764AbWE0CNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 22:13:20 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20060525202917.GB21926@csclub.uwaterloo.ca>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1FjoIp-0003RG-00@calista.inka.de>
Date: Sat, 27 May 2006 04:13:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:
> I always thought that was how it worked.  The first hostname in
> /etc/hosts on the line containing the short name was used as the FQDN.
> Maybe that is only a gnu hostname thing.  I seem to recall solaris had a
> domainname file that was used to find the domain part of the FQDN
> instead.

yes this is how hostname works (see the man page)

# Technically: The FQDN is the name gethostbyname(2) returns for the host
# name returned by gethostname(2).  The DNS domain name is the part after
# the first dot.

# Therefore  it  depends on the configuration (usually in /etc/host.conf)
# how you can change it. Usually (if the hosts file is parsed before DNS or
# NIS) you can change it in /etc/hosts.

And yes, this is broken, but who used hostname -f anyway?

BTW: the above works also (better?) if you set the utsname to the FQDN like
Linus does.

Gruss
Bernd
