Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318838AbSICUla>; Tue, 3 Sep 2002 16:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318914AbSICUl3>; Tue, 3 Sep 2002 16:41:29 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:23023
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318838AbSICUl2>; Tue, 3 Sep 2002 16:41:28 -0400
Subject: Re: lockup on Athlon systems, kernel race condition?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@zip.com.au>
Cc: Terence Ripperda <tripperda@nvidia.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3D750548.9D130AB3@zip.com.au>
References: <20020830204022.GC736@hygelac> <3D6FE062.A48B6F03@zip.com.au>
	<20020903183524.GC2343@hygelac>  <3D750548.9D130AB3@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 03 Sep 2002 21:46:53 +0100
Message-Id: <1031086013.21409.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-03 at 19:54, Andrew Morton wrote:
> Some systems will drop nasty messages in the logs when APIC checksum
> errors are detected.  And such systems will also be prone to lockups
> due to failed delivery.  But whether IPIs can be lost without any such
> warning signs: don't know, sorry.

Our IPI code requires the other end ack, so its pretty much impossible
for it to occur at the software end. The hardware in theory can also not
lose messages both because of queueing and checksums. On pentiums there
are documented errata with 3 interrupts matched to the same priority but
not on Athlon
