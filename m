Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbWEJRFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWEJRFA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 13:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbWEJRFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 13:05:00 -0400
Received: from wx-out-0102.google.com ([66.249.82.203]:15534 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964984AbWEJRE7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 13:04:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p0hzhTaOwsiwLGTlHaGG5HI3vcjV551olfxv7a7ZI4dU0b/oKxc5UO/c1Hqr1bOZx4SIXADImWjHACw9hPlVX62SEnpRd9wZVem0CLWHIdr9do2DZzX4OeryXabaoHZu2mUCu9Im2lgvOFtOxal77udwleD/a4tVjYmrCtwYHBU=
Message-ID: <2151339d0605101004l4a2153d4h40ec7db907ae5d43@mail.gmail.com>
Date: Wed, 10 May 2006 10:04:59 -0700
From: "Nathan Becker" <nathanbecker@gmail.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: USB 2.0 ehci failure with large amount of RAM (4GB) on x86_64
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <2151339d0605092237m4ef4e835k16b8c779f6ad7046@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2151339d0605032148n5d6936ay31ab017fbabc65b3@mail.gmail.com>
	 <200605041922.52243.david-b@pacbell.net>
	 <2151339d0605042246n1e40a496l8af646218edc781e@mail.gmail.com>
	 <200605061232.52303.david-b@pacbell.net>
	 <2151339d0605092237m4ef4e835k16b8c779f6ad7046@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my last message I sent a patch that I thought fixed the problem.

I made a mistake in my testing.  It turns out that my patch doesn't
have an effect on this problem.  What I discovered was a workaround: 
If I rmmod ehci-hcd and then modprobe it back in, usb 2.0 it works. 
That's what I did when I tested my patched version, so I mistakenly
thought it was my patch that fixed it.

So it seems that there is something that happens when the ehci-hcd
shuts down that helps initialize it to work properly.  What could it
be?
