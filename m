Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263746AbTCUV2W>; Fri, 21 Mar 2003 16:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbTCUV1O>; Fri, 21 Mar 2003 16:27:14 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:39140 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id <S262900AbTCUVYj>; Fri, 21 Mar 2003 16:24:39 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: time is ulong
References: <200303212002.h2LK2QtZ026205@hraefn.swansea.linux.org.uk>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 21 Mar 2003 13:35:34 -0800
In-Reply-To: <200303212002.h2LK2QtZ026205@hraefn.swansea.linux.org.uk>
Message-ID: <528yv8pfmh.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 21 Mar 2003 21:35:37.0246 (UTC) FILETIME=[CFCFE3E0:01C2EFF1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  > -#define INITIAL_JIFFIES ((unsigned int) (-300*HZ))
  > +#define INITIAL_JIFFIES ((unsigned long) (-300*HZ))

My understanding is that this (unsigned int) is intentional.  The goal
is for only the low 32 bits of jiffies to overflow, even on 64 bit
architectures.

 - Roland
