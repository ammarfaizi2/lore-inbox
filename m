Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWCZMaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWCZMaf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 07:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWCZMae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 07:30:34 -0500
Received: from smtpout.mac.com ([17.250.248.70]:58092 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751317AbWCZMae convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 07:30:34 -0500
In-Reply-To: <yw1x3bh5xut9.fsf@agrajag.inprovide.com>
References: <Pine.LNX.4.61.0603202207310.20060@yvahk01.tjqt.qr> <20060321082327.B653275@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0603202239110.11933@yvahk01.tjqt.qr> <20060321084619.E653275@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0603252232570.18484@yvahk01.tjqt.qr> <je1wwq2lqn.fsf@sykes.suse.de> <Pine.LNX.4.61.0603260023070.12891@yvahk01.tjqt.qr> <jewtei1434.fsf@sykes.suse.de> <Pine.LNX.4.61.0603261124320.22145@yvahk01.tjqt.qr> <yw1x3bh5xut9.fsf@agrajag.inprovide.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <0BE1D87A-29F0-4633-86FA-57AE5C846C33@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Parenthesize macros in xfs
Date: Sun, 26 Mar 2006 07:30:24 -0500
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 26, 2006, at 07:19:14, Måns Rullgård wrote:
> A double semicolon can cause all sorts of hard to debug problems.   
> Consider this:
>
> #define foo() bar();
> /* ... */
> if(x)
>     foo();
> else
>     baz();
>
> This will expand to syntactically invalid code because of the extra  
> semicolon.

More generically, the code "do { [...] } while(0)" can _always_ be  
substituted for the code "function_returning_void()" without changing  
the meaning of the surrounding code.  Look at the following examples:

for (i = 0; i < 10; i++) {
	macro();
}

for (i = 0; i < 10; i++)
	if (i > 5)
		macro1();
	else
		macro2();

Cheers,
Kyle Moffett

