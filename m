Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261438AbSJPVjo>; Wed, 16 Oct 2002 17:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261459AbSJPVi6>; Wed, 16 Oct 2002 17:38:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21428 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261450AbSJPViA>;
	Wed, 16 Oct 2002 17:38:00 -0400
Date: Wed, 16 Oct 2002 14:36:34 -0700 (PDT)
Message-Id: <20021016.143634.106131797.davem@redhat.com>
To: roy@karlsbakk.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] e1000 hardware checksumming support?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200210161654.05783.roy@karlsbakk.net>
References: <200210161654.05783.roy@karlsbakk.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
   Date: Wed, 16 Oct 2002 16:54:05 +0200
   
   Can Linux 2.4 use the hardware checksumming in the e1000 adapter?

Two things:

1) On output you only get checksumming if your applications
   use sendfile()

2) On input, since we have to copy the data anyways, we use
   csum_partial_copy because it costs the same as a memcpy.

   Actually, on some x86 cpus the checksum+copy is faster
   than the memcpy, but that is being fixed in current 2.5.x

