Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264689AbTE1LoH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 07:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264690AbTE1LoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 07:44:07 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48847
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264689AbTE1LoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 07:44:06 -0400
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ragnar Hojland Espinosa <ragnar@linalco.com>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       manish <manish@storadinc.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <20030528093654.GA20687@linalco.com>
References: <3ED2DE86.2070406@storadinc.com> <3ED3A2AB.3030907@gmx.net>
	 <3ED3A55E.8080807@storadinc.com> <200305271954.11635.m.c.p@wolk-project.de>
	 <20030528093654.GA20687@linalco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054119522.20167.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 May 2003 11:58:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-05-28 at 10:36, Ragnar Hojland Espinosa wrote:
> Actually it just happens in the fixing stage when burning prebuilt iso
> images from the hard disk (same IDE channel as the burner, 2.4.20)
> Having a completely frozen machine under X was quite panic inducing ;)

If you have a disk and the burner ont he same channel this is quite
normal. The fixate is a single ATAPI command and like all ATA commands
locks the bus to both master/slave for its duration of execution.

Its an IDE limitation

