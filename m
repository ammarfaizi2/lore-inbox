Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbTAFRFX>; Mon, 6 Jan 2003 12:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267057AbTAFRFX>; Mon, 6 Jan 2003 12:05:23 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:43653
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267043AbTAFRFK>; Mon, 6 Jan 2003 12:05:10 -0500
Subject: Re: NAPI and tg3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steffen Persvold <sp@scali.com>
Cc: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0301061707200.15870-100000@sp-laptop.isdn.scali.no>
References: <Pine.LNX.4.44.0301061707200.15870-100000@sp-laptop.isdn.scali.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041875880.17472.47.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 06 Jan 2003 17:58:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok I can try that, but what about the nice level of ksoftirqd ? Any 
> specific reason for it beeing 19 (lowest priority) and not 0 (equally to 
> most other processes in the system) ?

Its triggered (in theory but not practice) only when we are overloaded, in
which case we want to do other *useful* work first rather than using all
the cpu to process requests we can't fulfill

