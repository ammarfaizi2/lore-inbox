Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262783AbSJVOoF>; Tue, 22 Oct 2002 10:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbSJVOoF>; Tue, 22 Oct 2002 10:44:05 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:23481 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262783AbSJVOoE>; Tue, 22 Oct 2002 10:44:04 -0400
Subject: Re: [PATCH] i386 __verify_write fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DA9D3EF.9030000@quark.didntduck.org>
References: <3DA9D3EF.9030000@quark.didntduck.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 16:06:18 +0100
Message-Id: <1035299178.329.70.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-13 at 21:13, Brian Gerst wrote:
> mark the page read-only.  A 386 would continue to write to the page when 
> the first thread woke up again.  We need to prevent anyone from changing 
> the page permissions until we are done writing to userspace.  My 
> suggestion is to replace access_ok() with begin_user_{read,write}(), and 
> add end_user_{read,write}().  Thoughs?

For 2.6 with the time scale as it is I think we just block pre-emption
on 386. Its not a big deal since almost nobody uses 386 any more

