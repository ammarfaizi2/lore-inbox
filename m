Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbWAGIdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWAGIdz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 03:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbWAGIdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 03:33:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49111 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030360AbWAGIdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 03:33:54 -0500
Subject: Re: [patch 0/4] Series to allow a "const" file_operations struct
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060106162913.7621895c.akpm@osdl.org>
References: <1136583937.2940.90.camel@laptopd505.fenrus.org>
	 <1136584539.2940.105.camel@laptopd505.fenrus.org>
	 <43BEF338.3010403@cosmosbay.com>  <20060106162913.7621895c.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 09:33:46 +0100
Message-Id: <1136622827.2936.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Confused.   Why should this result in an aggregate reduction in vmlinux size?

there shouldn't be. It's just moving these things from the .data section
(where cachelines get dirtied all the time) to .rodata (where they're
not)

