Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129991AbRCAWZb>; Thu, 1 Mar 2001 17:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130053AbRCAWZM>; Thu, 1 Mar 2001 17:25:12 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18704 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129991AbRCAWZC>; Thu, 1 Mar 2001 17:25:02 -0500
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
To: mikeg@wen-online.de (Mike Galbraith)
Date: Thu, 1 Mar 2001 22:28:03 +0000 (GMT)
Cc: riel@conectiva.com.br (Rik van Riel),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (linux-kernel),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.33.0103012021470.1542-100000@mikeg.weiden.de> from "Mike Galbraith" at Mar 01, 2001 09:33:59 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14YbYL-0000G9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is no mechanysm in place that ensures that dirty pages can't
> get out of control, and they do in fact get out of control, and it
> is exaserbated (mho) by attempting to define 'too much I/O' without
> any information to base this definition upon.

I think this is a good point. If you do 'too much I/O' then the I/O gets
throttled by submit_bh(). The block I/O layer knows about 'too much I/O'.

