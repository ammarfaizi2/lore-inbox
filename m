Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264086AbTDPVfl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 17:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbTDPVfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 17:35:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62088 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264086AbTDPVfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 17:35:40 -0400
Date: Wed, 16 Apr 2003 14:40:35 -0700 (PDT)
Message-Id: <20030416.144035.130217416.davem@redhat.com>
To: akpm@digeo.com
Cc: willy@debian.org, ak@muc.de, linux-kernel@vger.kernel.org, anton@samba.org,
       schwidefsky@de.ibm.com, davidm@hpl.hp.com, matthew@wil.cx,
       ralf@linux-mips.org, rth@redhat.com
Subject: Re: Reduce struct page by 8 bytes on 64bit
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030416144311.46f32253.akpm@digeo.com>
References: <20030416133539.0ac01968.akpm@digeo.com>
	<20030416212651.GF1505@parcelfarce.linux.theplanet.co.uk>
	<20030416144311.46f32253.akpm@digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Wed, 16 Apr 2003 14:43:11 -0700
   
   Well are we sure that the `flags' and `count' fields will always fall into
   the same 256-byte range?  Wouldn't it subtly break if sizeof(struct page)
   became not a multiple of eight?  Will the compiler pad it out anyway?

As long as there is a long or pointer member, the structure
will be required to be 8 byte or better aligned.
