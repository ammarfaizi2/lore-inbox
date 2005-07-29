Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVG2Hm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVG2Hm0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 03:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbVG2HmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 03:42:23 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:8640 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262502AbVG2HkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 03:40:25 -0400
Date: Fri, 29 Jul 2005 09:40:14 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel guide to space (updated)
In-Reply-To: <20050728145353.GL11644@mellanox.co.il>
Message-ID: <Pine.LNX.4.61.0507290929250.26861@yvahk01.tjqt.qr>
References: <20050728145353.GL11644@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>3e. sizeof
>	space after the operator
>	no space if the operand is in barces

braces

>3f. Braces etc
>	() [] -> .

() parentheses (short form: parens)
[] square brackets
{} braces
<> dunno their name :p

>3i. if/else/do/while/for/switch
>	space between if/else/do/while and following/preceeding
>	statements/expressions, if any

Why this? if(a) {} is not any worse than if (a). I would make this an option.

>3j. return
>	space between return and following expression,
>	even if the operand is in barces

parentheses

>	return (a);

No unnecessary parentheses:

   return (3 + 7) * 5;
   return 1;

instead of

   return ((3 + 7) * 5);
   return (1);

>3k. Labels
>	goto and case labels should have a line of their own (possibly
>	with a comment)
>	no space before colon in labels
>
>int foobar()
>{
>	...
>foolabel: /* short comment */
>	foo();
>}

Would it be reasonable to say that the first column can be a space?
Some editors (e.g. joe) list the function in some status bar and do that based 
on the fact that all C code in a function is indented, and only the function 
header is non-indented. Putting a label statement fools the algorithm.
joe-bug or option for freedom?

>4a. Labels
>	case labels should be indented same as the switch statement.
>	statements occurring after a case label are indented by one level.
>
>	switch (foo) {
>	case foo:
>		bar();
>	default:
>		break;
>	}

switch(foo) {
default: {
	int somevar = dosomething;
	break;
}
}


What now? You've got two }} after another.



Jan Engelhardt
-- 
