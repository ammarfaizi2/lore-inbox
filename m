Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278269AbRJaIap>; Wed, 31 Oct 2001 03:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279277AbRJaIa0>; Wed, 31 Oct 2001 03:30:26 -0500
Received: from pizda.ninka.net ([216.101.162.242]:56704 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S278269AbRJaIaX>;
	Wed, 31 Oct 2001 03:30:23 -0500
Date: Wed, 31 Oct 2001 00:30:56 -0800 (PST)
Message-Id: <20011031.003056.63128206.davem@redhat.com>
To: pcg@goof.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-ac5 && vtun not working
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011031010500.B383@schmorp.de>
In-Reply-To: <5.1.0.14.0.20011029174700.08e93090@mail1>
	<20011029.175312.26299226.davem@redhat.com>
	<20011031010500.B383@schmorp.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
   Date: Wed, 31 Oct 2001 01:05:00 +0100

   On Mon, Oct 29, 2001 at 05:53:12PM -0800, "David S. Miller" <davem@redhat.com> wrote:
   > Basically, don't pass a string lack one "%d" into dev_alloc_name
   > because dev_alloc_name() runs sprintf on that string with an
   > integer argument.
   
   I fail to follow you - yes, dev_alloc_name calls sprintf on it, but
   sprintf works fine on strings without "%d", and dev_alloc_name also works
   fine (despite a little suboptimal).
   
You're right, it should allow the "string has no '%' at all" case
as well.  Please, someone send me a patch which does this.

Franks a lot,
David S. Miller
davem@redhat.com
