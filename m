Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262968AbUKYEuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262968AbUKYEuY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 23:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbUKYEuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 23:50:23 -0500
Received: from zeus.kernel.org ([204.152.189.113]:46792 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262968AbUKYEtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 23:49:31 -0500
Date: Wed, 24 Nov 2004 20:33:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Work around for periodic do_gettimeofday hang
Message-Id: <20041124203349.7982efb7.akpm@osdl.org>
In-Reply-To: <1101356864.4007.35.camel@mulgrave>
References: <1101314988.1714.194.camel@mulgrave>
	<1101323621.2811.24.camel@laptop.fenrus.org>
	<1101356864.4007.35.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
>  +config X86_HZ
>  +       int "Clock Tick Rate"
>  +       default 1000 if !(M386 || M486 || M586 || M586TSC || M586MMX)	
>  +       default 100 if (M386 || M486 || M586 || M586TSC || M586MMX)	
>  +       help
>  +	  Select the kernel clock tick rate in interrupts per second.
>  +	  Slower processors should choose 100; everything else 1000.

I guess we don't need the help, given that it's not a menuisable option. 
(There was a make-HZ-selectable patch once, and Linus spat it out).

Silly question: how come do_gettimeofday() is hanging?
