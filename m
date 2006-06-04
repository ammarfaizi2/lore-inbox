Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932215AbWFDJHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWFDJHt (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 05:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWFDJHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 05:07:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8385 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932215AbWFDJHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 05:07:49 -0400
Date: Sun, 4 Jun 2006 02:07:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Fengguang Wu <wfg@mail.ustc.edu.cn>
Cc: Valdis.Kletnieks@vt.edu, diegocg@gmail.com, lista1@comhem.se,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] readahead: initial method - expected read size - fix
 fastcall
Message-Id: <20060604020738.31f43cb0.akpm@osdl.org>
In-Reply-To: <349406446.10828@ustc.edu.cn>
References: <349406446.10828@ustc.edu.cn>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2006 15:34:15 +0800
Fengguang Wu <wfg@mail.ustc.edu.cn> wrote:

> Remove 'fastcall' directive for function readahead_close().
> 
> It has drawn concerns from Andrew Morton.

Well.  I think fastcall is ugly and vaguely silly.  Now if we has a
really_really_fastcall then I'd like to use that!


> Now I have some benchmarks
> on it, and proved it as a _false_ optimization.

Sorry, I don't believe this will be measurable (and with CONFIG_REGPARM
it'll be a no-op).

But I'm always glad to see a fastcall disappear ;)

