Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286521AbSBZNMl>; Tue, 26 Feb 2002 08:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286895AbSBZNMc>; Tue, 26 Feb 2002 08:12:32 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:48861 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S286521AbSBZNM1>;
	Tue, 26 Feb 2002 08:12:27 -0500
Date: Wed, 27 Feb 2002 00:11:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: christophe.barbe.ml@online.fr, linux-kernel@vger.kernel.org
Subject: Re: suspend/resume and 3c59x
Message-Id: <20020227001144.328c210c.sfr@canb.auug.org.au>
In-Reply-To: <3C7AD0AC.13A554DA@zip.com.au>
In-Reply-To: <20020225200056.GW12719@ufies.org>
	<3C7A9C75.F6A4BA05@zip.com.au>
	<3C7A9C75.F6A4BA05@zip.com.au>
	<20020225233242.GA5370@ufies.org>
	<3C7AD0AC.13A554DA@zip.com.au>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002 16:02:52 -0800 Andrew Morton <akpm@zip.com.au> wrote:
>
> Just for the record: Both Christophe's 3c<mumble> and my 3c556B
> mini-PCI NIC failed to survive APM resumes in 2.4.17.  But something
> outside the 3c59x driver got fixed somewhere in the 2.4.18-pre series,
> and resume works OK in 2.4.18.

We now notify (and wait for a response from) user mode processes about
the pending suspend BEFORE we notify the drivers.  We used to do this the
other way around (which was never correct - mea culpa).

This MAY have changed the behaviour of the drivers ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
