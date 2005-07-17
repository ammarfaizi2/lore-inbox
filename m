Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVGQVxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVGQVxL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 17:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVGQVxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 17:53:11 -0400
Received: from mail.charite.de ([160.45.207.131]:60900 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S261404AbVGQVxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 17:53:07 -0400
Date: Sun, 17 Jul 2005 23:53:06 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13.3 flooding my logs
Message-ID: <20050717215306.GK10995@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.13.2 didn't do this, now I'm getting (from dmesg):

PROTO=17 127.0.0.1:53 127.0.0.1:56872 L=56 S=0x00 I=40463 F=0x4000 T=64
ip_local_deliver: bad skb: PRE_ROUTING LOCAL_IN LOCAL_OUT POST_ROUTING 
skb: pf=2 (unowned) dev=lo len=56
PROTO=17 127.0.0.1:56872 127.0.0.1:53 L=56 S=0x00 I=12024 F=0x4000 T=64
ip_local_deliver: bad skb: PRE_ROUTING LOCAL_IN LOCAL_OUT POST_ROUTING 
skb: pf=2 (unowned) dev=lo len=89
PROTO=17 127.0.0.1:53 127.0.0.1:56872 L=89 S=0x00 I=40464 F=0x4000 T=64
ip_local_deliver: bad skb: PRE_ROUTING LOCAL_IN LOCAL_OUT POST_ROUTING 
skb: pf=2 (unowned) dev=lo len=124
PROTO=17 127.0.0.1:53 127.0.0.1:56729 L=124 S=0x00 I=40465 F=0x4000 T=64
ip_local_deliver: bad skb: PRE_ROUTING LOCAL_IN LOCAL_OUT POST_ROUTING 
skb: pf=2 (unowned) dev=lo len=152
PROTO=1 127.0.0.1:0 127.0.0.1:0 L=152 S=0xC0 I=41998 F=0x0000 T=64

What is it? Looks like debug output, but I haven't turned any of that
on.

-- 
_________________________________________________

  Charité - Universitätsmedizin Berlin
_________________________________________________

  Ralf Hildebrandt
   i.A. Geschäftsbereich Informationsmanagement
   Campus Benjamin Franklin
   Hindenburgdamm 30 | Berlin
   Tel. +49 30 450 570155 | Fax +49 30 450 570962
   Ralf.Hildebrandt@charite.de
   http://www.charite.de
