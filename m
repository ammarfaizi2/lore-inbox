Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135386AbREHVKB>; Tue, 8 May 2001 17:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135395AbREHVJv>; Tue, 8 May 2001 17:09:51 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:51215 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S135386AbREHVJo>;
	Tue, 8 May 2001 17:09:44 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105082108.f48L8X1154536@saturn.cs.uml.edu>
Subject: Re: pci_pool_free from IRQ
To: zaitcev@redhat.com (Pete Zaitcev)
Date: Tue, 8 May 2001 17:08:33 -0400 (EDT)
Cc: david-b@pacbell.net, johannes@erdfelt.com, zaitcev@redhat.com,
        rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20010508170114.A29075@devserv.devel.redhat.com> from "Pete Zaitcev" at May 08, 2001 05:01:14 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev writes:

> Russel King complained that you might be calling pci_consistent_free
> from an interrupt, which is unsafe on ARM.

This sure makes life difficult. Device removal events can be called
from interrupt context according to Documentation/pci.txt. This is
certainly a place where one might want to call pci_consistent_free.
