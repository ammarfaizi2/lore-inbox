Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTJ3T2Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 14:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbTJ3T2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 14:28:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:13529 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262788AbTJ3T2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 14:28:24 -0500
Date: Thu, 30 Oct 2003 11:28:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Mario \"jorge\" Di Nitto" <jorge78@inwind.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8-mm1 failure..
Message-Id: <20031030112843.475f1ddd.akpm@osdl.org>
In-Reply-To: <200310301300.55605.jorge78@inwind.it>
References: <200310202008.23294.jorge78@inwind.it>
	<20031020120029.78a69465.akpm@osdl.org>
	<200310301300.55605.jorge78@inwind.it>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mario \"jorge\" Di Nitto" <jorge78@inwind.it> wrote:
>
> > Please set CONFIG_KALLSYMS=y and resend the oops trace so we can
> > see where it crashed, thanks.
> 
> I've changed some items in .config, and after next reboot I've got other 
> failures like those I already wrote.
> The last boot shows multiple oops (4 I think, in dmesg), see attached files 
> for details.

OK, thanks.

Now please add the string "initcall_debug" to your kernel boot command
line.

It will cause a lot of things like

	calling initcall 0xNNNNNNNN

to be printed out.  Please take the last one which is printed out before
the crash and look it up in your System.map.

That will tell us which initcall initialisation function the kernel was
running when it crashed.

