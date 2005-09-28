Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVI1TIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVI1TIC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 15:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbVI1TIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 15:08:02 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:24382 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750719AbVI1TIA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 15:08:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tEStYGJ12rAR44QKqI3hcd6C9X8CrABTpB5FAXuU/Ua+WF3iUK8mbXVxLOp8V9IEgzBW3pI1jgDWCUuVCDVrJcP9FDxLDAoGCq2f/HJEKc+0iBgBT/PnceacUXnIxnlIYWLE9/gFy9ZeIhV+A9euHhpxNWibnLPjhr8rtXIFCRQ=
Message-ID: <b41d010d05092812079475644@mail.gmail.com>
Date: Wed, 28 Sep 2005 12:07:59 -0700
From: Carlo Calica <ccalica@gmail.com>
Reply-To: Carlo Calica <ccalica@gmail.com>
To: Paul Blazejowski <paulb@blazebox.homeip.net>
Subject: Re: 2.6.14-rc2-mm1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       xorg@lists.freedesktop.org
In-Reply-To: <20050928045630.GA9960@blazebox.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050925220037.GA8776@blazebox.homeip.net>
	 <20050925164421.75c734d2.akpm@osdl.org>
	 <20050928045630.GA9960@blazebox.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/05, Paul Blazejowski <paulb@blazebox.homeip.net> wrote:
> No 2.6.12 is not OK. I don't think there's any regression between the
> recent kernels. It just does not work on 3 of them i tried so far.
>

Another data point:

I'm unable to reproduce on a PATA install.  Specifically, booting on a
PATA HD with sata_nv as a module.  When booting on a SATA HD with
sata_nv compiled in, I get the race.  Setting irq 1,5 (keyboard and
libata) handlers to cpu0 affinity and X affinity to cpu0 solves the
problem.

I haven't had time to try booting SATA with sata_nv as a module in initrd.

--
Carlo J. Calica
