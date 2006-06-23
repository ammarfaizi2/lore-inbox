Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWFWOG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWFWOG0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWFWOG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:06:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45721 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750724AbWFWOGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:06:25 -0400
Subject: Re: make PROT_WRITE imply PROT_READ
From: Arjan van de Ven <arjan@infradead.org>
To: Jason Baron <jbaron@redhat.com>
Cc: Robert Hancock <hancockr@shaw.ca>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606230934360.24102@dhcp83-5.boston.redhat.com>
References: <fa.PuMM6IwflUYh1MWILO9rb6z4fvY@ifi.uio.no>
	 <449B42B3.6010908@shaw.ca>
	 <Pine.LNX.4.64.0606230934360.24102@dhcp83-5.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 16:06:21 +0200
Message-Id: <1151071581.3204.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> hi,
> 
> So if i create a PROT_WRITE only mapping and then read from first and then 
> writte to it a get a SEGV. However, if i write to it first and then read 
> from it, i don't get a SEGV...Why should the read/write ordering matter? 

it matters only on those cpus that don't have explicit/separate read
permissions (just like PROT_EXEC is implied on cpus that don't have a
special permission bit for that)...



