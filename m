Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbVDGST1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbVDGST1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 14:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVDGST0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 14:19:26 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:24406 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262539AbVDGSTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 14:19:20 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: Renate Meijer <kleuske@xs4all.nl>
Subject: Re: [08/08] uml: va_copy fix
Date: Thu, 7 Apr 2005 20:25:34 +0200
User-Agent: KMail/1.7.2
Cc: jdike@karaya.com, linux-kernel@vger.kernel.org,
       =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       stable@kernel.org, Greg KH <gregkh@suse.de>
References: <20050405164539.GA17299@kroah.com> <200504062109.51344.blaisorblade@yahoo.it> <448f048a060cc7db1fc00a489c86ac05@xs4all.nl>
In-Reply-To: <448f048a060cc7db1fc00a489c86ac05@xs4all.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504072025.34976.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 April 2005 11:16, Renate Meijer wrote:
> On Apr 6, 2005, at 9:09 PM, Blaisorblade wrote:

> > Btw: I've not investigated which one of the two behaviours is the
> > buggy one -
> > if you know, maybe you or I can report it.
>
>  From a strict ISO-C point of view, both are. It's a gcc-specific
> "feature" which (agreed) does come in handy sometimes.

Well, for "range" assignments GCC mustn't complain, but for the rest the 
double assignment laziness is not very useful. Could they at least add a 
-Wsomething inside -Wall or -W for this problem?

> However it makes 
> it quite hard to say which is the buggy version, since the
> "appropriate" behavior
> is a question of definition (by the gcc-folks). They may even argue
> that, having changed their minds about it, neither is buggy, but both
> conform to the specifications (for that specific functionality).
>
> That's pretty much the trouble with relying on gcc-extensions: since
> there's no standard, it's difficult to tell what's wrong and what's
> right. I'll dive into it.
>
> Regards,
>
> Renate Meijer.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

