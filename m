Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264166AbUEDQod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264166AbUEDQod (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 12:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264514AbUEDQod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 12:44:33 -0400
Received: from palrel12.hp.com ([156.153.255.237]:62385 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264166AbUEDQob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 12:44:31 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16535.51307.910896.950581@napali.hpl.hp.com>
Date: Tue, 4 May 2004 09:44:27 -0700
To: Arjan van de Ven <arjanv@redhat.com>
Cc: davidm@hpl.hp.com, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, bunk@fs.tum.de, eyal@eyal.emu.id.au,
       linux-dvb-maintainer@linuxtv.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
In-Reply-To: <20040504075555.GB13287@devserv.devel.redhat.com>
References: <20040501201342.GL2541@fs.tum.de>
	<Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org>
	<20040501161035.67205a1f.akpm@osdl.org>
	<Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org>
	<20040501175134.243b389c.akpm@osdl.org>
	<16534.35355.671554.321611@napali.hpl.hp.com>
	<Pine.LNX.4.58.0405031336470.1589@ppc970.osdl.org>
	<16534.45589.62353.878714@napali.hpl.hp.com>
	<1083618424.3843.12.camel@laptop.fenrus.com>
	<16534.51724.578183.845357@napali.hpl.hp.com>
	<20040504075555.GB13287@devserv.devel.redhat.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 4 May 2004 09:55:55 +0200, Arjan van de Ven <arjanv@redhat.com> said:

  Arjan> On Mon, May 03, 2004 at 03:39:08PM -0700, David Mosberger wrote:
  >> >>>>> On Mon, 03 May 2004 23:07:04 +0200, Arjan van de Ven <arjanv@redhat.com> said:

  Arjan> Exporting sys_mlock() for a kernel module soooo sounds wrong
  Arjan> to me

  >> On what grounds?  What alternative are you suggesting?

  Arjan> if the module wants to pin userspace pages there are plenty
  Arjan> of alternatives.  Heck I suspect what they want is to mmap a
  Arjan> device like most V4L drivers do, instead of doing it the
  Arjan> windows way (let the app malloc and then pin)

You may well be right (it's hard to tell what they're using mlock()
for since its called from the binary-only portion of the driver).
However, as long as x86 supports the _syscallN() macros, they won't
change.

	--david
