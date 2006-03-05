Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWCESkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWCESkU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 13:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWCESkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 13:40:20 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:39064 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750990AbWCESkT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 13:40:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dKEBWmpK7P/ZsW0F5ljRELS2F7dkX5xGvkOSws62DvjchYTampBbK4Zn6AFjJ02isG9K57MJKgcnGlSvXYkJWLKDl0m/Q5BFzs1Cq8JTnsOpSNjtlwGbAu3Y3ZPNF+dJcyy/ceC6vP2BzJRuKKCDeqRqcNog2Un5GoWgqfUvkDc=
Message-ID: <7d40d7190603051040h17da06caw@mail.gmail.com>
Date: Sun, 5 Mar 2006 19:40:18 +0100
From: "Aritz Bastida" <aritzbastida@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: MMAP: How a driver can get called on mprotect()
Cc: "Jan-Benedict Glaw" <jbglaw@lug-owl.de>
In-Reply-To: <20060305182240.GH19232@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7d40d7190603051012p16ed826cx@mail.gmail.com>
	 <20060305182240.GH19232@lug-owl.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, what hardware is it for and where can we download the driver to
> have a view at it? That'd probably help suggesting something...
>

Well actually is a virtual memory driver somewhat based on scullp
device in the book Linux Device Drivers 3rd edition.

Nonetheless the question is the same: a char device with mmap
implemented can get called any time a new vma is created or destroyed
(a process creating a new mmap):  vma_open() and vma_close().

But if a user process changes the mmap protections calling mprotect()?
How can the driver know about that? Is there any way to do that?

Thanks
