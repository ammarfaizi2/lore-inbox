Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161148AbWGNAKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbWGNAKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 20:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161150AbWGNAKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 20:10:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:228 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161148AbWGNAKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 20:10:46 -0400
Subject: Re: RFC: cleaning up the in-kernel headers
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
In-Reply-To: <20060711160639.GY13938@stusta.de>
References: <20060711160639.GY13938@stusta.de>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 01:11:14 +0100
Message-Id: <1152835875.31372.27.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 18:06 +0200, Adrian Bunk wrote:
> I'd like to cleanup the mess of the in-kernel headers, based on the 
> following rules:
> - every header should #include everything it uses
> - remove unneeded #include's from headers 

If you also fancy removing gratuitous instances of #ifdef __KERNEL__,
that might be useful...

$ for a in `grep -rl __KERNEL__ include` ; do DIR=`dirname $a` ;
NAME=`basename $a` ; grep -q $NAME $DIR/Kbuild 2>/dev/null || grep -q
$NAME include/asm-generic/Kbuild.asm || echo $DIR/$NAME ; done | wc -l
481


-- 
dwmw2

