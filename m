Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTFJQCJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 12:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263305AbTFJQCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 12:02:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21405 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263295AbTFJQCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 12:02:07 -0400
Date: Tue, 10 Jun 2003 09:12:17 -0700 (PDT)
Message-Id: <20030610.091217.112601441.davem@redhat.com>
To: James.Bottomley@SteelEye.com
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: New struct sock_common breaks parisc 64 bit compiles with a
 misalignment
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1055221067.11728.14.camel@mulgrave>
References: <1055221067.11728.14.camel@mulgrave>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Bottomley <James.Bottomley@SteelEye.com>
   Date: 09 Jun 2003 23:57:46 -0500
   
   A fix that seems to work for me on parisc64 is to move the atomic_t out
   of the end of struct sock_common and back into the two other structures
   (so struct sock_common now ends on 0 mod 8).
   
I would suggest instead to add the proper alignment attribute
to the appropriate members of the tw bucket.
