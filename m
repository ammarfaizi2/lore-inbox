Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267431AbTACCj1>; Thu, 2 Jan 2003 21:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267432AbTACCj1>; Thu, 2 Jan 2003 21:39:27 -0500
Received: from pizda.ninka.net ([216.101.162.242]:10177 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267431AbTACCj0>;
	Thu, 2 Jan 2003 21:39:26 -0500
Date: Thu, 02 Jan 2003 18:40:04 -0800 (PST)
Message-Id: <20030102.184004.09755984.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: lm@bitmover.com, tom@rhadamanthys.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TCP Zero Copy for mmapped files
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1041555419.24901.86.camel@irongate.swansea.linux.org.uk>
References: <1041549644.24829.66.camel@irongate.swansea.linux.org.uk>
	<20030102.151600.129375771.davem@redhat.com>
	<1041555419.24901.86.camel@irongate.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 03 Jan 2003 00:56:59 +0000

   On Thu, 2003-01-02 at 23:16, David S. Miller wrote:    
   > With sendfile() all of this goes straight to the page cache directly
   > without a VMA lookup.
   
   With a nasty unpleasant splat the moment you do modification on the
   content at all. For static objects sendfile is certainly superior,
   
Sendfile does not protect against content changes to the
file contents.  We don't lock the pages, we merely grab
references to them for the network I/O.
