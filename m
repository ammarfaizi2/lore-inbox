Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSIPHYm>; Mon, 16 Sep 2002 03:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315925AbSIPHYm>; Mon, 16 Sep 2002 03:24:42 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:35847 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S315923AbSIPHYl>; Mon, 16 Sep 2002 03:24:41 -0400
Message-ID: <3D85886B.3AB1284@aitel.hist.no>
Date: Mon, 16 Sep 2002 09:29:47 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Killing/balancing processes when overcommited
References: <Pine.LNX.4.44L.0209131943390.1857-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> If you kill the process that requests memory, the sequence often
> goes as follows:
> 
> 1) memory is exhausted
> 
> 2) the network driver can't allocate memory and
>    spits out a message
> 
> 3) syslogd and/or klogd get killed
> 
> Clearly you want to be a bit smarter about which process to kill.

Ill-implemented klogd/syslogd.  Pre-allocating a little memory
is one way to go, or drop messages until allocation
becomes possible again.  Then log a complaint about
messages missing due to a temporary OOM.

Helge Hafting
