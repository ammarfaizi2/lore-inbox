Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262928AbTEGGjN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 02:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTEGGjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 02:39:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57325 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262928AbTEGGjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 02:39:12 -0400
Date: Tue, 06 May 2003 22:44:05 -0700 (PDT)
Message-Id: <20030506.224405.26296708.davem@redhat.com>
To: hch@infradead.org
Cc: thomas@horsten.com, voidcartman@yahoo.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
 defined (trivial)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030507074557.A9197@infradead.org>
References: <200305070850.59912.voidcartman@yahoo.com>
	<200305070744.27207.thomas@horsten.com>
	<20030507074557.A9197@infradead.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christoph Hellwig <hch@infradead.org>
   Date: Wed, 7 May 2003 07:45:57 +0100
   
   That's highly broken because his libc was compiled against 2.2
   headers.  You must never use different headers in
   /usr/include/Pasm,linux} then those your libc was compiled against.
   
While I understand this problem, this line of reasoning simply does
not apply for headers that libc/glibc/whatever are agnostic about.
