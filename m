Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266041AbTAYBoe>; Fri, 24 Jan 2003 20:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266043AbTAYBoe>; Fri, 24 Jan 2003 20:44:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:18670 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266041AbTAYBoe>;
	Fri, 24 Jan 2003 20:44:34 -0500
Date: Fri, 24 Jan 2003 17:42:14 -0800 (PST)
Message-Id: <20030124.174214.24965528.davem@redhat.com>
To: Jeff.Wiedemeier@hp.com
Cc: ink@jurassic.park.msu.ru, jgarzik@pobox.com, willy@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] tg3.c: pci_{save,restore}_extended_state
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030124193353.A6814@dsnt25.mro.cpqcorp.net>
References: <20030125014102.A825@localhost.park.msu.ru>
	<20030124.143252.97527503.davem@redhat.com>
	<20030124193353.A6814@dsnt25.mro.cpqcorp.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>
   Date: Fri, 24 Jan 2003 19:33:53 -0500
   
   Then the tg3 code after the pci_restore_extended_state could be
        if (pci_using_msi(tp->pdev))
           tw32(MSGINT_MODE, MSGINT_MODE_ENABLE);

Ok.

I wonder if it would be a good idea to write MSGINT_MODE_RESET
to this register in the other cases.
