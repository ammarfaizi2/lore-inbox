Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263932AbRFMMNn>; Wed, 13 Jun 2001 08:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263933AbRFMMNd>; Wed, 13 Jun 2001 08:13:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11685 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263932AbRFMMNQ>;
	Wed, 13 Jun 2001 08:13:16 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15143.22734.747077.588558@pizda.ninka.net>
Date: Wed, 13 Jun 2001 05:13:02 -0700 (PDT)
To: Keith Owens <kaos@ocs.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.6-pre3 unresolved symbol do_softirq
In-Reply-To: <8272.992434020@ocs4.ocs-net>
In-Reply-To: <8272.992434020@ocs4.ocs-net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Keith Owens writes:
 > do_softirq is called from asm code which does not get preprocessed.
 > It needs to be exported with no version.

It can get preprocessed if you know how.  Simply use the "i" asm
constraint for an extra argument, and use the symbol there.  For
example:

	__asm__("%0" : : "i" (my_versioned_symbol));

It works and we've been doing it on sparc for ages.

Later,
David S. Miller
davem@redhat.com
