Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269454AbRHAFsQ>; Wed, 1 Aug 2001 01:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269653AbRHAFsG>; Wed, 1 Aug 2001 01:48:06 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:47884 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S269651AbRHAFsB>;
	Wed, 1 Aug 2001 01:48:01 -0400
From: Andrew Tridgell <tridge@valinux.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0108010023050.8866-100000@freak.distro.conectiva>
	(message from Marcelo Tosatti on Wed, 1 Aug 2001 00:32:55 -0300 (BRT))
Subject: Re: 2.4.8preX VM problems
Reply-To: tridge@valinux.com
In-Reply-To: <Pine.LNX.4.21.0108010023050.8866-100000@freak.distro.conectiva>
Message-Id: <20010801054326.EDB5E4399@lists.samba.org>
Date: Tue, 31 Jul 2001 22:43:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Marcelo wrote:
> Could you please apply
> http://bazar.conectiva.com.br/~marcelo/patches/v2.4/2.4.7pre9/zoned.patch
> on top of 2.4.7 and try to reproduce the problem ? 

yep, that's the culprit. Running an original 2.4.7 with the zoned
patch applied showed the same slowdowns as 2.4.8preX. Looks like the
zoned patch has a problem when the buffer cache grows beyond 800M.

