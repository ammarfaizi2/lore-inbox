Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbUJZIlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbUJZIlH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 04:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbUJZIlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 04:41:07 -0400
Received: from canuck.infradead.org ([205.233.218.70]:7954 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262190AbUJZIlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 04:41:05 -0400
Subject: Re: [PATCH] remove dead tcp exports
From: Arjan van de Ven <arjan@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "David S. Miller" <davem@davemloft.net>,
       Werner Almesberger <wa@almesberger.net>, hch@lst.de, davem@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1098765665.9404.5.camel@krustophenia.net>
References: <20041024134309.GB20267@lst.de>
	 <20041026000710.D3841@almesberger.net>
	 <20041025204147.667ee2b1.davem@davemloft.net>
	 <1098765665.9404.5.camel@krustophenia.net>
Content-Type: text/plain
Message-Id: <1098780051.2789.17.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 26 Oct 2004 10:40:51 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-26 at 00:41 -0400, Lee Revell wrote:

> Is this really a compelling reason to remove them?  For example ALSA
> provides an API for driver writers, just because a certain function
> happens not to be used by any does not mean is never will be or that it
> should not.

sometimes such "spurious" exports still make sense. Most of the time
they don't, and during these cleanups we've found several functions for
which the only "user" was the export, eg entirely dead code. 
Also nobody in the entire tree using a part of the API is a pretty good
sign that the API isn't good or even supposed to be used. (again,
exceptions possible, which is why cleaning this stuff is manual work and
not a script to just nuke it all)
-- 

