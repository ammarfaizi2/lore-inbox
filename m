Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266909AbRGKXTQ>; Wed, 11 Jul 2001 19:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266921AbRGKXTG>; Wed, 11 Jul 2001 19:19:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51584 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266909AbRGKXSw>;
	Wed, 11 Jul 2001 19:18:52 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15180.57050.435082.420248@pizda.ninka.net>
Date: Wed, 11 Jul 2001 16:18:50 -0700 (PDT)
To: Andi Kleen <ak@muc.de>
Cc: Herve Masson <herve@mindstep.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: csum_partial() / i386 does not handle unaligned address with empty region properly
In-Reply-To: <20010711191721.38160@colin.muc.de>
In-Reply-To: <065f01c10a3f$cbe849a0$0400a8c0@swan>
	<20010711191721.38160@colin.muc.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen writes:
 > AFAIK the standard kernel never passes zero length to csum_partial so there
 > is no bug in it. If IPVS does that it probably needs to be fixed.
 > I would report it to the IPVS maintainers.

Yes, better to put the rare check into the weird callers instead
of punishing everyone who does not allow this to occur by other
means already.

Later,
David S. Miller
davem@redhat.com
