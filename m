Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272712AbTHPKoB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 06:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272731AbTHPKoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 06:44:01 -0400
Received: from AMarseille-201-1-3-2.w193-253.abo.wanadoo.fr ([193.253.250.2]:15911
	"EHLO gaston") by vger.kernel.org with ESMTP id S272712AbTHPKoA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 06:44:00 -0400
Subject: Re: [BUG] slab debug vs. L1 alignement
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3F3E02EE.8080909@colorfullife.com>
References: <3F3D558D.5050803@colorfullife.com>
	 <1060990883.581.87.camel@gaston>  <3F3D8D3B.3020708@colorfullife.com>
	 <1061026667.881.100.camel@gaston>  <3F3E02EE.8080909@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061030600.582.121.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Aug 2003 12:43:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >
> Hmm. That means slab debugging did it's job: The driver contains the 
> wrong assumption that all pointers are cache line aligned. Without slab 
> debugging, this would result in rare data corruptions in O_DIRECT apps. 
> With slab debugging on, it's exposed immediately.

As we discussed on IRC, I think SCSI host drivers (at least) can assume
beeing passed aligned buffers, if somebody don't agree, please speak
up ;) Christoph said that O_DIRECT has strict alignement rules too.

Ben.

