Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWABWfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWABWfa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 17:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWABWfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 17:35:30 -0500
Received: from [81.2.110.250] ([81.2.110.250]:61895 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751112AbWABWf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 17:35:29 -0500
Subject: Re: Re; system keeps freezing once every 24 hours / random apps
	crashing
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Missel <peter.missel@onlinehome.de>
Cc: video4linux-list@redhat.com, Mark v Wolher <trilight@ns666.com>,
       Jiri Slaby <xslaby@fi.muni.cz>, Sami Farin <7atbggg02@sneakemail.com>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>, jesper.juhl@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, s0348365@sms.ed.ac.uk,
       rlrevell@joe-job.com, arjan@infradead.org
In-Reply-To: <200601020020.12190.peter.missel@onlinehome.de>
References: <200512310027.47757.s0348365@sms.ed.ac.uk>
	 <20060101191221.7E34322AEAC@anxur.fi.muni.cz> <43B82F87.5010804@ns666.com>
	 <200601020020.12190.peter.missel@onlinehome.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Jan 2006 22:29:43 +0000
Message-Id: <1136240983.8570.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-01-02 at 00:20 +0100, Peter Missel wrote:
> Grabdisplay causes (roughly) twice the traffic. Overlay mode runs the TV 
> stream straight into the graphics card, peer-to-peer, while grabdisplay 
> streams into RAM, lets the CPU read from there, scale, and push into the 
> graphics card.
> Pure overlay mode also produces zero CPU load.


Grab display also stresses the main memory bus and bus arbitration logic
which caused problems on some older chipsets many of which handled
overlay mode fine. Equally some other older chipsets couldn't get
PCI<->PCI right but worked for main memory.

BT8x8's are very good for finding chipset problems.

