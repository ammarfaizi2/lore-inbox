Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSGZAND>; Thu, 25 Jul 2002 20:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSGZAND>; Thu, 25 Jul 2002 20:13:03 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:61714 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316674AbSGZAND>;
	Thu, 25 Jul 2002 20:13:03 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207260015.g6Q0FC5485648@saturn.cs.uml.edu>
Subject: Re: [RFC/CFT] cmd640 irqlocking fixes
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Thu, 25 Jul 2002 20:15:12 -0400 (EDT)
Cc: martin@dalecki.de, vojtech@suse.cz (Vojtech Pavlik),
       alan@lxorguk.ukuu.org.uk (Alan Cox),
       wli@holomorphy.com (William Lee Irwin III),
       linux-kernel@vger.kernel.org
In-Reply-To: <20020725105538.B21927@ucw.cz> from "Vojtech Pavlik" at Jul 25, 2002 10:55:38 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik writes:

> We really should be using pci_write_config_* and
> create vlb_write_config_* in CMD640 for the VLB accesses, panic() in
> case we have a PCI system that uses BIOS and we found a CMD640

You should not panic, since there may be another disk controller.
Just disable the CMD640 by grabbing the resources and forgetting them.
