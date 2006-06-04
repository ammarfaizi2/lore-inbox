Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751095AbWFDJZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWFDJZS (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 05:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWFDJZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 05:25:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62404 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751095AbWFDJZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 05:25:17 -0400
Subject: Re: [PATCH] readahead: initial method - expected read size - fix
	fastcall
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Fengguang Wu <wfg@mail.ustc.edu.cn>, Valdis.Kletnieks@vt.edu,
        diegocg@gmail.com, lista1@comhem.se, linux-kernel@vger.kernel.org
In-Reply-To: <20060604020738.31f43cb0.akpm@osdl.org>
References: <349406446.10828@ustc.edu.cn>
	 <20060604020738.31f43cb0.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 04 Jun 2006 11:25:03 +0200
Message-Id: <1149413103.3109.90.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-04 at 02:07 -0700, Andrew Morton wrote:
> On Sun, 4 Jun 2006 15:34:15 +0800
> Fengguang Wu <wfg@mail.ustc.edu.cn> wrote:
> 
> > Remove 'fastcall' directive for function readahead_close().
> > 
> > It has drawn concerns from Andrew Morton.
> 
> Well.  I think fastcall is ugly and vaguely silly.  Now if we has a
> really_really_fastcall then I'd like to use that!
> 
> 
> > Now I have some benchmarks
> > on it, and proved it as a _false_ optimization.
> 
> Sorry, I don't believe this will be measurable (and with CONFIG_REGPARM
> it'll be a no-op).

we should just make CONFIG_REGPARM be "it" always (and thus make it go
away as config option) and then just remove all "fastcall" from the
kernel...

