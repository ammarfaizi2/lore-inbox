Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270634AbRHWVxs>; Thu, 23 Aug 2001 17:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270557AbRHWVxj>; Thu, 23 Aug 2001 17:53:39 -0400
Received: from xilofon.it.uc3m.es ([163.117.139.114]:5504 "EHLO
	xilofon.it.uc3m.es") by vger.kernel.org with ESMTP
	id <S270615AbRHWVx2>; Thu, 23 Aug 2001 17:53:28 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108232153.XAA06231@xilofon.it.uc3m.es>
Subject: ram device not initialised to zero in 2.4.8
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Thu, 23 Aug 2001 23:53:43 +0200 (CEST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see what harm it does, but the ram devices are full of
interesting data if you read them after setting them up. Either
this is a security hole waiting to happen, or somebody is being
very inventive with the fill ...

I did

     mke2fs -m0 /dev/ram2 4096
     dd if=/dev/ram2 | od -a | less

and had a good read.

Peter
