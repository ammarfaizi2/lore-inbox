Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264161AbUEHHCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264161AbUEHHCz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 03:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264160AbUEHHCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 03:02:55 -0400
Received: from viefep12-int.chello.at ([213.46.255.25]:23828 "EHLO
	viefep12-int.chello.at") by vger.kernel.org with ESMTP
	id S264161AbUEHHCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 03:02:54 -0400
From: Anubis <kerub@gmx.net>
To: linux-kernel@vger.kernel.org, petri.koistinen@iki.fi, lathiat@sixlabs.org,
       janitor@sternwelten.at
Subject: Re: Bug for making NETFILTER
Date: Sat, 8 May 2004 09:04:59 +0200
User-Agent: KMail/1.6
References: <200405050743.42833.kerub@gmx.net> <20040505175653.GA2250@mars.ravnborg.org>
In-Reply-To: <20040505175653.GA2250@mars.ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405080904.59703.kerub@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 May 2004 19:56, Sam Ravnborg wrote:
> > make[3]: *** No rule to make target `net/ipv4/netfilter/ipt_mark.o',
> > needed by `net/ipv4/netfilter/built-in.o'.  Stop.
> > for linux-2.6.5
> Check permissions on the file - or maybe something else went wrong whan
> patching up the kernel src?

Permissions are ok, but filename probably is not: ipt_MARK.c
Anyway I did not patch the kernel but got the full distribution.

I copied ipt_MARK.c to ipt_mark.c and got the following:
  CC      net/ipv4/netfilter/ipt_mark.o
net/ipv4/netfilter/ipt_mark.c:13:43: linux/netfilter_ipv4/ipt_mark.h: No such 
file or directory
net/ipv4/netfilter/ipt_mark.c: In function `match':
net/ipv4/netfilter/ipt_mark.c:30: error: dereferencing pointer to incomplete 
type
net/ipv4/netfilter/ipt_mark.c:30: error: dereferencing pointer to incomplete 
type
net/ipv4/netfilter/ipt_mark.c:30: error: dereferencing pointer to incomplete 
type
net/ipv4/netfilter/ipt_mark.c: In function `checkentry':
net/ipv4/netfilter/ipt_mark.c:40: error: invalid application of `sizeof' to an 
incomplete type
make[3]: *** [net/ipv4/netfilter/ipt_mark.o] Error 1
