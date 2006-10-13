Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWJMQpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWJMQpu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWJMQpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:45:44 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5802 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751352AbWJMQpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:45:19 -0400
Subject: Re: Hardware bug or kernel bug?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Johnson <dj@david-web.co.uk>
Cc: Jarek Poplawski <jarkao2@o2.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
In-Reply-To: <200610131724.40631.dj@david-web.co.uk>
References: <20061013085605.GA1690@ff.dom.local>
	 <200610131256.54546.dj@david-web.co.uk>
	 <20061013130648.GC1690@ff.dom.local>
	 <200610131724.40631.dj@david-web.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Oct 2006 18:11:51 +0100
Message-Id: <1160759511.25218.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-13 am 17:24 +0100, ysgrifennodd David Johnson:
> IDE controller, then continuing. Could the same thing be happening in Linux? 
> If Linux can't talk to the IDE controller when trying to write to disk, how 
> does it handle that?

It will timeout and then retry the command. It's not the most ideal
situation to end up in but I'd expect to see a DMA timeout and a retry
or two in the log not a crash.

