Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWF3KAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWF3KAp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 06:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWF3KAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 06:00:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11155 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750715AbWF3KAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 06:00:44 -0400
Subject: Re: kernel module debugging question
From: Arjan van de Ven <arjan@infradead.org>
To: "s.a." <sancelot@free.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44A518D7.2060105@free.fr>
References: <44A518D7.2060105@free.fr>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 12:00:42 +0200
Message-Id: <1151661642.11434.23.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 12:28 +0000, s.a. wrote:
> Hi,
> I have got the following fault , can you provide me with more details
> about the problem ?
> Best Regards

Hi,

you disabled CONFIG_KALLSYMS in your kernel configuration, which means
the backtrace isn't really useful for anyone to look at (unless you run
ksymoops with the exact System.map)... the problem is that it only shows
the addresses of the bad guys, but not the names. Those addresses are
different for each compilation, and you can use YOUR System.map file to
decode. However it's a lot more robust to let the kernel decode it for
you by enabling CONFIG_KALLSYMS....

Greetings,
    Arjan van de Ven



