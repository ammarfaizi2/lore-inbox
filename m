Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVEANrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVEANrn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 09:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVEANrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 09:47:43 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:21219 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261611AbVEANrj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 09:47:39 -0400
Subject: Re: Non-blocking sockets, connect(), and socket states
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bernard Blackham <bernard@blackham.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Werner Almesberger <werner@almesberger.net>
In-Reply-To: <20050428103451.GG4798@blackham.com.au>
References: <20050428103451.GG4798@blackham.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114955160.11309.160.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 01 May 2005 14:46:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-04-28 at 11:34, Bernard Blackham wrote:
> Should it be the kernel's responsibility to set SS_CONNECTED when
> the connection is established? Or should I go file bugs and submit
> patches on all the applications that use non-blocking sockets and
> don't call connect() a second time?

See posix 1003.1g drafts. I believe from the state diagram there that
you should call connect() again once it completes.


