Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280335AbRJaRkz>; Wed, 31 Oct 2001 12:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280345AbRJaRkm>; Wed, 31 Oct 2001 12:40:42 -0500
Received: from pizda.ninka.net ([216.101.162.242]:23428 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280335AbRJaRki>;
	Wed, 31 Oct 2001 12:40:38 -0500
Date: Wed, 31 Oct 2001 09:41:12 -0800 (PST)
Message-Id: <20011031.094112.125896630.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: pre6 BUG oops
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BE03401.406B8585@mandrakesoft.com>
In-Reply-To: <3BE03401.406B8585@mandrakesoft.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Wed, 31 Oct 2001 12:25:21 -0500

   2.4.14-pre6 on UP alpha, newly reformatted and reinstalled :)
   
   Machine was nowhere near OOM, and no other adverse messages appeared in
   dmesg.  An rpm build and an rpm install were running in parallel.
   
Hmmm... the oops suggests that truncate_complete_page() gets a page
not in the page cache.  The page count should be at least 2 when
it gets passed there.

Franks a lot,
David S. Miller
davem@redhat.com
