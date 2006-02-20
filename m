Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932658AbWBTGIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbWBTGIg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 01:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbWBTGIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 01:08:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50605 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932658AbWBTGIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 01:08:35 -0500
Date: Sun, 19 Feb 2006 22:06:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Luke Yang" <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH] Fix undefined symbols for nommu architecture
Message-Id: <20060219220653.58168056.akpm@osdl.org>
In-Reply-To: <489ecd0c0602192157o72d9ba94r1751822dd65abcc3@mail.gmail.com>
References: <489ecd0c0602192024o2a136ddera294876ea8fd44a5@mail.gmail.com>
	<20060219214244.03147dba.akpm@osdl.org>
	<489ecd0c0602192157o72d9ba94r1751822dd65abcc3@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luke Yang" <luke.adi@gmail.com> wrote:
>
> > Not so sure about this one.  Does randomize_va_space actually make sense in
>  > a nommu environment?  I guess we could load relocatable binaries into a
>  > randomised place, but I'm not sure that this is implemented?
>    No, it doesn't make sense now.  NOMMU architectures don't really use
>  it. I put it here just to avoid "undefined symbol" error.
>  >
>  > If no, then it would make more sense to do
>  >
>  >         #define randomize_va_space 0
>    Yes, this is much better.  Do I need to resend a new patch?

Yes please - I'm not set up to compile any nommu architectures.
