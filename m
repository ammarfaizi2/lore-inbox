Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbTEVXhc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 19:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTEVXhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 19:37:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47840 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263429AbTEVXhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 19:37:31 -0400
Date: Thu, 22 May 2003 16:48:45 -0700 (PDT)
Message-Id: <20030522.164845.48515977.davem@redhat.com>
To: schlicht@uni-mannheim.de
Cc: akpm@digeo.com, mfc@krycek.org, linux-kernel@vger.kernel.org
Subject: Re: Error during compile of 2.5.69-mm8
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305230147.00730.schlicht@uni-mannheim.de>
References: <200305230128.06412.schlicht@uni-mannheim.de>
	<20030522.162913.115921853.davem@redhat.com>
	<200305230147.00730.schlicht@uni-mannheim.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Schlichter <schlicht@uni-mannheim.de>
   Date: Fri, 23 May 2003 01:47:00 +0200
   
   There was a discussion about SET_MODULE_OWNER here on the list, once.
   You can find it here:

I know about it and in fact Rusty is the one that told me
to do what I did with SET_MODULE_OWNER.

FACT: SET_MODULE_OWNER() tracks how to set the module reference
      for a struct netdevice.

It always lived in netdevice.h and always served exactly this purpose.
So when I deleted ->owner from struct netdevice, SET_MODULE_OWNER
became a nop.

Therefore, it was a complete error for anyone else to start using this
macro for other structures.
