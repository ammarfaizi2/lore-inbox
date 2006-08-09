Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWHISQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWHISQI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 14:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWHISQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 14:16:08 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5576 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751292AbWHISQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 14:16:06 -0400
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Edgar Toernig <froese@gmx.de>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, viro@zeniv.linux.org.uk, tytso@mit.edu,
       tigran@veritas.com
In-Reply-To: <20060809200019.0bd5eecd.froese@gmx.de>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <20060805122936.GC5417@ucw.cz> <20060807101745.61f21826.froese@gmx.de>
	 <84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>
	 <20060807224144.3bb64ac4.froese@gmx.de>
	 <1155040157.5729.34.camel@localhost.localdomain>
	 <20060809104155.48ad3c77.froese@gmx.de>
	 <1155120128.5729.143.camel@localhost.localdomain>
	 <20060809200019.0bd5eecd.froese@gmx.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Aug 2006 19:35:48 +0100
Message-Id: <1155148549.5729.249.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-09 am 20:00 +0200, ysgrifennodd Edgar Toernig:
> And killing them is not OK?  "fuser -km /dev/cdrom" already covers both
> cases, mounted somewhere and opened for special access.

fuser is quite easy to race, it doesn't handle all sorts of corner cases
like namespaces either. Its a crude blunt instrument that sometimes
works and is very slow.

> Sorry if I sound a little bit anal.  IMO, a generic revoke is a pretty
> sharp sword which is given to ordinary users and I have a very uneasy
> feeling.  They can dig in the innards of other people's processes - a
> clean headshot by root is something different ...

I can see your concern about arbitary files, but I'm not sure it holds
simply because the tricks already exist via other methods.

