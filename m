Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbSLIOPO>; Mon, 9 Dec 2002 09:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbSLIOPN>; Mon, 9 Dec 2002 09:15:13 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:8636 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265523AbSLIOPN>; Mon, 9 Dec 2002 09:15:13 -0500
Subject: Re: BUG in 2.5.50
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>, roy@karlsbakk.net,
       zwane@holomorphy.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@redhat.com
In-Reply-To: <200212091346.gB9DkcgN000690@darkstar.example.net>
References: <200212091346.gB9DkcgN000690@darkstar.example.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Dec 2002 14:58:57 +0000
Message-Id: <1039445937.10475.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-09 at 13:46, John Bradford wrote:
> Is IDE TCQ liable to corrupt data on read-only volumes or just
> read-write?  The problem with nobody using it, is that it never gets
> tested - if there are no known issues with read-only use it would be
> nice to know.

The big problem with TCQ is that it only works with some versions of
some conrollers and oopses on others. At the moment the TCQ support isnt
integrated into drivera that override some ide dma ops and there is no
mechanism Jens included for a controller to indicate no-tcq.

Pre-empt is another matter. IDE locking is rather hosed, pre-empt is
showing up existing and long standing problems I think. I've been
commenting bits of ide about locking ready to attempt to actually fix
the locking once the more pressing problems are solved

