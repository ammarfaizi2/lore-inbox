Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUFERBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUFERBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 13:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbUFERBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 13:01:25 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:58570 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261711AbUFERBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 13:01:24 -0400
Subject: Re: jff2 filesystem in vanilla
From: David Woodhouse <dwmw2@infradead.org>
To: Daniel Egger <de@axiros.com>
Cc: cijoml@volny.cz, linux-kernel@vger.kernel.org
In-Reply-To: <97F190B4-B6F5-11D8-B781-000A958E35DC@axiros.com>
References: <200406041000.41147.cijoml@volny.cz>
	 <F84CE3DA-B605-11D8-B781-000A958E35DC@axiros.com>
	 <1086390590.4588.70.camel@imladris.demon.co.uk>
	 <3F4B6D09-B6CA-11D8-B781-000A958E35DC@axiros.com>
	 <1086425211.4588.88.camel@imladris.demon.co.uk>
	 <97F190B4-B6F5-11D8-B781-000A958E35DC@axiros.com>
Content-Type: text/plain
Message-Id: <1086454880.4588.594.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sat, 05 Jun 2004 18:01:21 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-05 at 15:38 +0200, Daniel Egger wrote:
> On 05.06.2004, at 10:46, David Woodhouse wrote:
> > If you're going to use JFFS2 on CF, you should really investigate using
> > the write-buffer we implemented for NAND flash, but without the ECC
> > parts.

> However, do you have any specific pointers where to look?

fs/jffs2/wbuf.c has most of the magic for buffering writes on NAND
flash. We want to use that, but we want to avoid the ECC handling which
we also do on NAND flash.

The other thing that'll benefit you is checkpointing, which I keep
threatening to implement but haven't yet got round to.

-- 
dwmw2


