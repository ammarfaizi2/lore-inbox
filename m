Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbVKUBUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbVKUBUL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 20:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVKUBUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 20:20:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:10913 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932163AbVKUBUJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 20:20:09 -0500
Date: Mon, 21 Nov 2005 01:20:06 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: "David S. Miller" <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] I2O: SPARC fixes
Message-ID: <20051121012006.GF27946@ftp.linux.org.uk>
References: <437E7ADB.5080200@shadowconnect.com> <20051118.172230.126076770.davem@davemloft.net> <1132371039.5238.14.camel@localhost.localdomain> <20051118.203707.129707514.davem@davemloft.net> <4380EDB1.1080308@shadowconnect.com> <20051120225256.GC27946@ftp.linux.org.uk> <20051120230714.GD27946@ftp.linux.org.uk> <20051120232158.GE27946@ftp.linux.org.uk> <4381194A.3080609@shadowconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4381194A.3080609@shadowconnect.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 01:48:10AM +0100, Markus Lidel wrote:
> Yep, you're right...  the memcpy_fromio is wrong... It should be:
> 
> memcpy_fromio(&evt->body[1], &msg->body[1], size * 4);
> 
> as you already mentioned...

BTW, should that be memcpy() or memcpy_fromio()?  IOW, what memory
does msg point to?
