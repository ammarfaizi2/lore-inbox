Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270510AbTG1PbU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 11:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270648AbTG1PbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 11:31:19 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:7823 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S270510AbTG1PaE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 11:30:04 -0400
Date: Mon, 28 Jul 2003 17:43:51 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pete Zaitcev <zaitcev@redhat.com>,
       Chris Heath <chris@heathens.co.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i8042 problem
In-Reply-To: <20030728145452.GA1753@win.tue.nl>
Message-ID: <Pine.GSO.3.96.1030728173054.15233C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003, Andries Brouwer wrote:

> > Well, are timeouts needed at all?
> 
> Yes. We send a command to the keyboard. It may react, or it may not.

 But we need not wait for that actively.  If we are unsure about a result
of a command, then we may send a command in question followed with an echo
request.  This assures an IRQ will finally arrive and if no command
response arrives before an echo response, then the keyboard ignored the
command.  I used this approach many years ago to differ between PS/2
keyboards (which respond with 0xfa,0xab,0x83 to a request for ID) and
genuine PC/AT ones (which respond with lone 0xfa).  It worked. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

