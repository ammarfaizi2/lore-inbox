Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261986AbSJIVXc>; Wed, 9 Oct 2002 17:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262007AbSJIVXb>; Wed, 9 Oct 2002 17:23:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36787 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261986AbSJIVXb> convert rfc822-to-8bit;
	Wed, 9 Oct 2002 17:23:31 -0400
Date: Wed, 09 Oct 2002 14:21:48 -0700 (PDT)
Message-Id: <20021009.142148.131274439.davem@redhat.com>
To: nick@technisys.com.ar
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.41 does not build: ipv6/addrconf.c: case label
 (htonln(something)) does not reduce to an integer constant
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DA47DA1.4050804@technisys.com.ar>
References: <3DA47DA1.4050804@technisys.com.ar>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Nicolás Lichtmaier <nick@technisys.com.ar>
   Date: Wed, 09 Oct 2002 16:04:01 -0300

   In that line:
                   switch((st & htonl(0x00FF0000))) {
                           case htonl(0x00010000):
   
   Perhaps it's a matter of includes again.

This is fixed in the current sources, just change the
"htonl" to "__constant_htonl" in the case statements.
