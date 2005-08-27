Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751620AbVH0ORk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbVH0ORk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 10:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbVH0ORk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 10:17:40 -0400
Received: from [81.2.110.250] ([81.2.110.250]:47235 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751617AbVH0ORj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 10:17:39 -0400
Subject: Re: [patch] IBM HDAPS accelerometer driver, with probing.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Robert Love <rml@novell.com>, dtor_core@ameritech.net,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050827052929.GA15782@mandriva.com>
References: <1125094725.18155.120.camel@betsy>
	 <d120d50005082615445557d776@mail.gmail.com>
	 <1125099479.32272.29.camel@phantasy>  <20050827052929.GA15782@mandriva.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 27 Aug 2005 15:45:52 +0100
Message-Id: <1125153952.24593.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-08-27 at 02:29 -0300, Arnaldo Carvalho de Melo wrote:
> > unlikely() can result in better, smaller, faster code.  and it acts as a
> > nice directive to programmers reading the code.
> 
> Agreed, keep them :-)

If the unlikely() hints are being used correctly and the compiler is
doing the right thing then it ought to be worthwhile, if not then fix
the compiler.

Remember however unlikely() does have a code size cost on some
processors and a small performance cost so it really has to mean
very_unlikely().

