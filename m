Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291525AbSBHKND>; Fri, 8 Feb 2002 05:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291531AbSBHKMy>; Fri, 8 Feb 2002 05:12:54 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:15367 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S291525AbSBHKMs>; Fri, 8 Feb 2002 05:12:48 -0500
Date: Fri, 8 Feb 2002 11:12:18 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Harald Welte <laforge@gnumonks.org>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org,
        hpa@zytor.com
Subject: Re: [SOLUTION] Re: Fw: 2.4.18-pre9: iptables screwed?
Message-ID: <20020208101218.GD12130@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20020208.010839.112626203.davem@redhat.com> <20020208105548.P26676@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020208105548.P26676@sunbeam.de.gnumonks.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 10:55:48AM +0100, Harald Welte wrote:

> > > I get the following error with iptables on 2.4.18-pre9:
> > > 
> > > sudo iptables-restore < /etc/sysconfig/iptables
> > > iptables-restore: libiptc/libip4tc.c:384: do_check: Assertion
> > > `h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
> > > Abort (core dumped)
> 
> The code you are quoting is only defined if debugging is compiled into 
> the iptables package. The default distribution of the iptables package
> does _not_ ship with debugging enabled.

Right, upon further analysis the redhat RPM is overriding COPT_FLAGS
and removes the -DNDEBUG from the compile line.

> We always want to make sure that nobody needs to update the iptables
> package during the 2.4.x stable kernel series. Because of this (sane)
> policy, we are keeping back a whole bunch of changes.  We can't just
> silently abandon backwards compatibility.

Hey, you keeped backwards compatibility _only_ for those compiling 
the non debug version of the package. I believe this remains however
a half-bug...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
