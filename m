Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270578AbRHIUan>; Thu, 9 Aug 2001 16:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270570AbRHIUad>; Thu, 9 Aug 2001 16:30:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6272 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270581AbRHIUaT>;
	Thu, 9 Aug 2001 16:30:19 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15218.62166.839967.47354@pizda.ninka.net>
Date: Thu, 9 Aug 2001 13:30:14 -0700 (PDT)
To: Sampsa Ranta <sampsa@netsonic.fi>
Cc: Alan Cox <laughing@shared-source.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.7-ac9 (breaks ATM connect)
In-Reply-To: <Pine.LNX.4.33.0108092225440.31580-100000@nalle.netsonic.fi>
In-Reply-To: <Pine.LNX.4.33.0108092210260.31580-100000@nalle.netsonic.fi>
	<Pine.LNX.4.33.0108092225440.31580-100000@nalle.netsonic.fi>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sampsa Ranta writes:
 > Pardon me, bugs come in too easy..
 > 
 > -           vci != ATM_VCI_ANY && vci >> dev->ci_range.vci_bits))
 > +           vci != ATM_VCI_ANY && vci >= 1 << dev->ci_range.vci_bits))
 > 

This is rediculious, why has this expression changed when right
above it is the same thing:

          vpi >> dev->ci_range.vpi_bits) || (vci != ATM_VCI_UNSPEC &&

Shouldn't we be changing that "vpi >> dev->ci_range.vpi_bits" boolean
test as well?

Later,
David S. Miller
davem@redhat.com
