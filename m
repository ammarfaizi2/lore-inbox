Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268396AbUHQUCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268396AbUHQUCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268397AbUHQUCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:02:52 -0400
Received: from gprs214-122.eurotel.cz ([160.218.214.122]:1922 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268396AbUHQUAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:00:36 -0400
Date: Tue, 17 Aug 2004 22:00:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Coding style: do_this(a,b) vs. do_this(a, b)
Message-ID: <20040817200020.GA21731@elf.ucw.cz>
References: <1092743463.5759.1403.camel@cube> <20040817164046.GA19009@elf.ucw.cz> <1092762468.5759.1524.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092762468.5759.1524.camel@cube>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, you maybe can't tell the difference, but I definitely can. You
> > can read code aligned by two spaces, right?
> 
> Sure, but you can't mix that in the same file
> with something else. Indentation and braces have
> to be consistent. Other stuff matters far less.

This kind of spacing matters, too.

> > > We don't need any more bureaucracy.
> > > 
> > > do_this(a,b); (1)
> > > do_this(a, b); (2)
> > > do_this (a,b);
> > 
> > This looks extremely bad.
> > 
> > > do_this (a, b);
> > > 
> > > I can read them all. I might notice the space in
> > > front of the '(', but I might not. Even putting a
> > > space in front of the ';' isn't unreadable.
> > > 
> > > People will pass laws until they are choked off,
> > > unable to move without being in violation of some
> > > silly little thing.
> > 
> > I've seen people "fixing" code from (2) to (1), because they thought I
> > prefer (1). (And I definitely don't). So yes, it is important.
> 
> Spaces are good for grouping things to increase readability.
> So one might do this:
> 
> foo(a,b,c,d,e,f);

This looks ugly.

> bar(a+b, a-b);  // space needed for readability
> baz(a,b, c,d);  // suppose a and b logically go together, as do c and d
> zzz(a==b && c==d);   // common for an "if"

Would be okay. Notice that I did not add a rule, I just fixed the
examples to be consistent with each other.

Anyway, as in common english, there should be space after ",". There
may be exception to the rule (your baz example), but...

Here's the patch again. macrofun() is used as an example, but it looks
ugly, and is not consistent with the rest of the document.
								Pavel

--- clean/Documentation/CodingStyle	2004-05-20 23:08:01.000000000 +0200
+++ linux/Documentation/CodingStyle	2004-06-06 00:27:11.000000000 +0200
@@ -356,11 +356,11 @@
 
 Macros with multiple statements should be enclosed in a do - while block:
 
-#define macrofun(a,b,c) 			\
+#define macrofun(a, b, c) 			\
 	do {					\
 		if (a == 5)			\
-			do_this(b,c);		\
-	} while (0)
+			do_this(b, c);		\
+	} while(0)
 
 Things to avoid when using macros:
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
