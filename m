Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267154AbTAFX3M>; Mon, 6 Jan 2003 18:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267203AbTAFX3L>; Mon, 6 Jan 2003 18:29:11 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16859 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267154AbTAFX3L>;
	Mon, 6 Jan 2003 18:29:11 -0500
Date: Mon, 06 Jan 2003 15:29:18 -0800 (PST)
Message-Id: <20030106.152918.78008785.davem@redhat.com>
To: gianni@ecsc.co.uk
Cc: alan@lxorguk.ukuu.org.uk, lm@bitmover.com, tom@rhadamanthys.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TCP Zero Copy for mmapped files
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1041863779.13078.3.camel@lemsip>
References: <20030103010107.GB6416@work.bitmover.com>
	<1041559195.24901.119.camel@irongate.swansea.linux.org.uk>
	<1041863779.13078.3.camel@lemsip>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gianni Tedesco <gianni@ecsc.co.uk>
   Date: 06 Jan 2003 14:36:19 +0000
   
   If your web data rarely changes, it could also be all the files stored
   in a hashfile database covered by one large mmap, eliminating filesystem
   overhead (and vma overhead).

You still would eat a VMA lookup each and every send.
