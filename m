Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVBHWnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVBHWnM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 17:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVBHWnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 17:43:12 -0500
Received: from hera.kernel.org ([209.128.68.125]:63148 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261601AbVBHWmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 17:42:05 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: the "Turing Attack" (was: Sabotaged PaXtest)
Date: Tue, 8 Feb 2005 22:41:44 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cubf78$2s2$1@terminus.zytor.com>
References: <42080689.15768.1B0C5E5F@localhost> <42093CC7.5086.1FC83D3E@localhost> <20050208164815.GA9903@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1107902504 2947 127.0.0.1 (8 Feb 2005 22:41:44 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 8 Feb 2005 22:41:44 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20050208164815.GA9903@elte.hu>
By author:    Ingo Molnar <mingo@elte.hu>
In newsgroup: linux.dev.kernel
> 
> This, on the face of it, seems like a ridiculous possibility as the
> chances of that are reverse proportional to the number of bits necessary
> to implement the simplest Turing Machine. (which for anything even
> closely usable are on the order of 2^10000, less likely than the
> likelyhood of us all living to the end of the Universe.)
> 

2^10000?  Not even close.  You can build a fully Turing-complete
interpreter in a few tens of bytes (a few hundred bits) on most
architectures, and you have to consider ALL bit combinations that can
form an accidental Turing machine.

What is far less clear is whether or not you can use that accidental
Turing machine to do real damage.  After all, it's not computation (in
the strict sense) that causes security violations, it's I/O.  Thus,
the severity of the problem depends on which I/O primitives the
accidental Turing machine happens to embody.  Note that writing to the
memory of the host process is considered I/O for this purpose.

	-hpa
