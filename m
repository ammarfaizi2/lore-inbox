Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263842AbTH1KIx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 06:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbTH1KIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 06:08:01 -0400
Received: from www.erfrakon.de ([193.197.159.57]:46341 "EHLO www.erfrakon.de")
	by vger.kernel.org with ESMTP id S263870AbTH1Jyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 05:54:44 -0400
From: Martin Konold <martin.konold@erfrakon.de>
Organization: erfrakon
To: Timo Sirainen <tss@iki.fi>
Subject: Re: Lockless file reading
Date: Thu, 28 Aug 2003 11:48:39 +0200
User-Agent: KMail/kroupware-1.0.0
References: <3217CEE6-D906-11D7-A165-000393CC2E90@iki.fi> <200308281113.59112.martin.konold@erfrakon.de> <1062062858.1454.254.camel@hurina>
In-Reply-To: <1062062858.1454.254.camel@hurina>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308281148.39515.martin.konold@erfrakon.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thursday 28 August 2003 11:27 am schrieben Sie:

Hi,

> It's not about CPU usage. It's mostly about being able to modify the
> file even when there's thousands of simultaneous readers that could
> otherwise keep the file locked almost constantly.

No, the readers only have to check if the file got locked by the writer(s).
  
> Also it'd be nice to support NFS with .lock files since no-one really
> uses lockd.

IMHO a lock file on nfs is the most inefficient locking mechanism in case of 
readers and writer(s) on the same machine.

BTW: What about moving this thread away from linux-kernel? It is already clear 
that the kernel does not provide these guarantees you asked for.

Regards,
-- martin

Dipl.-Phys. Martin Konold
e r f r a k o n
Erlewein, Frank, Konold & Partner - Beratende Ingenieure und Physiker
Nobelstrasse 15, 70569 Stuttgart, Germany
fon: 0711 67400963, fax: 0711 67400959
email: martin.konold@erfrakon.de

