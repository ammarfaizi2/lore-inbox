Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316823AbSGVLSs>; Mon, 22 Jul 2002 07:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316821AbSGVLRp>; Mon, 22 Jul 2002 07:17:45 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:9981 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316768AbSGVLQ5>; Mon, 22 Jul 2002 07:16:57 -0400
Subject: Re: EINTR on close() in Linux?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ketil Froyn <ketil-kernel@froyn.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40L0.0207221221580.1417-100000@ketil.np>
References: <Pine.LNX.4.40L0.0207221221580.1417-100000@ketil.np>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Jul 2002 13:32:48 +0100
Message-Id: <1027341168.31782.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 11:38, Ketil Froyn wrote:
> 
> If Linux returns EINTR and tears down the fd, this code is bad because

Linux doesn't return -EINTR from close(). It did for a brief while
during development by accident.

While the standard permits it, sanity suggests otherwise (see earlier
discussions)

