Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317457AbSGTS5k>; Sat, 20 Jul 2002 14:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317463AbSGTS5k>; Sat, 20 Jul 2002 14:57:40 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:49137 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317457AbSGTS5j>; Sat, 20 Jul 2002 14:57:39 -0400
Subject: Re: [patch 2/9] 2.5.6 lm_sensors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Albert Cranford <ac9410@bellsouth.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020720010417.GA4557@conectiva.com.br>
References: <3D381CD1.6A0B9909@bellsouth.net>
	<1027130877.14314.6.camel@irongate.swansea.linux.org.uk> 
	<20020720010417.GA4557@conectiva.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 Jul 2002 21:12:26 +0100
Message-Id: <1027195946.16818.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-20 at 02:04, Arnaldo Carvalho de Melo wrote:
> Is there any other machine that is known to get fubar when using this code?
> Perhaps a THINKPAD_SUPPORT in "Processor Types and Features", like there is
> already for Toshiba and Dell laptops, that would disable the lm_sensors code,
> and besides I think that this code should be marked EXPERIMENTAL, so that
> users would be warned about these problems.

That is nothing like safe enough. The current approach it takes is IMHO
backwards. The probing stuff isnt safe. Any laptop could have this kind
of stuff lurking.

I would much rather see DMI tables used - both the DMI entry that is
meant for this and board id matches. That way it would only activate on
systems that it is known to be safe on. It would also require no user
configuration, which again could lead to problems.

We have a DMI parser, and we can encourage vendors (or suicidal users)
to contribute table entries.


