Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbUKDRFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbUKDRFZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbUKDRFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:05:25 -0500
Received: from brown.brainfood.com ([146.82.138.61]:24711 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S262292AbUKDRFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:05:15 -0500
Date: Thu, 4 Nov 2004 10:59:34 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
cc: jdike@karaya.com, blaisorblade_spam@yahoo.it, linux-kernel@vger.kernel.org,
       user-mode-linux-user@lists.sourceforge.net
Subject: Re: [PATCH] extend the limits for command line 
In-Reply-To: <Pine.LNX.4.61.0411040859130.18123@webhosting.rdsbv.ro>
Message-ID: <Pine.LNX.4.58.0411041059120.1229@gradall.private.brainfood.com>
References: <Pine.LNX.4.61.0411040859130.18123@webhosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2004, Catalin(ux aka Dino) BOIE wrote:

> Hello!
>
> (I resend this because I get no feedback.)
>
> Testing UML on my project, I hit the limit for command line with something like
> this:
>
> default \
>          mem=64M \
>          ubda=COW,/data/UML4/roots/ROOT1 \
>          ubdb=SWAP \
>          ubdc=CONF.tar \
>          ${HSSTR} \
>          eth0=daemon,fe:fd:39:bd:cc:d7,,/data/UML4/conf/example1/socks/SW1
> eth1=daemon,fe:fd:01:01:01:12,,/data/UML4/conf/example1/socks/SW2
> eth2=daemon,fe:fd:01:01:01:99,,/data/UML4/conf/example1/socks/SW4
> eth3=daemon,fe:fd:01:01:01:03,,/data/UML4/conf/example1/socks/SW5
> eth4=daemon,fe:fd:01:01:01:04,,/data/UML4/conf/example1/socks/SW6
> eth5=daemon,fe:fd:01:01:01:81,,/data/UML4/conf/example1/socks/SW8p1
> eth6=daemon,fe:fd:3f:a9:35:e2,,/data/UML4/conf/EXTERN/E1  \
>          con=null \
>          ssl0=port:9101 \
>          umid=example1-pc1 \
>          @pc1@
>
>
> Patch to extend the limits (buffer and number of args/envs) is attached.
> Please consider including it because UML is intended to be run with such
> long lines.
> I'm open to other alternatives as a Kconfig entry for this.

Actually, I should redo/update my patch that lets uml parse a config file.
