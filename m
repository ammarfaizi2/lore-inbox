Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262922AbUCKHg3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 02:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbUCKHg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 02:36:29 -0500
Received: from alt.aurema.com ([203.217.18.57]:44205 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262922AbUCKHgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 02:36:25 -0500
Message-ID: <405016E2.4030208@aurema.com>
Date: Thu, 11 Mar 2004 18:36:02 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Linus Torvalds <torvalds@osdl.org>, root@chaos.analogic.com,
       linux-kernel@vger.kernel.org,
       "Godbole, Amarendra (GE Consumer & Industrial)" 
	<Amarendra.Godbole@ge.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: (0 == foo), rather than (foo == 0)
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com>	<20040310100215.1b707504.rddunlap@osdl.org>	<Pine.LNX.4.53.0403101324120.18709@chaos>	<404F9E28.4040706@aurema.com>	<Pine.LNX.4.58.0403101832580.1045@ppc970.osdl.org> <20040311065041.GB14537@alpha.home.local>
In-Reply-To: <20040311065041.GB14537@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Hi,
> 
> On Wed, Mar 10, 2004 at 06:36:22PM -0800, Linus Torvalds wrote:
> 
>>And while "0 == foo" may be logically the same thing as "foo == 0", the 
>>fact is, the latter is what people are used to seeing. And by being used 
>>to seeing it, they have an easier time thinking about it.
>>
>>As a result, using the former just tends to increase peoples confusion by
>>making code harder to read, which in turn tends to increase the chance of 
>>bugs.
> 
> 
> I have a friend who constantly uses it, and his code is unreadable, because
> sometimes, a "0 == xxx" becomes "0 <= xxx" or "0 >= xxx" which is difficult
> to understand. Thinking that xxx is negative because it's written on the
> right side of a >= is complicated. And the worst he does is when he uses
> functions : 
> 
>    if (0 < strcmp(a, "xxx")) ...
>    if (sizeof(t) > read(fd, t, sizeof(t)) ...
> 
> I have already helped him track bugs in his programs, and some of them were
> just related to this usage, because nobody's brain can understand these
> constructions immediately without thinking a bit. So I'm all against this
> sort of thing.

One final note.  I agree with all the statements of how awkward and 
unnatural the back to front boolean expressions look but I had adopted 
this technique (for myself) as a means of overcoming design shortcomings 
in the C language.  I intend to keep doing it in my private code (as 
it's saved my bacon a number of times) but will conform to Linus's 
standards for any contributions/patches I submit for kernel code (just 
as I would conform for any other person's standards if I were to 
contribute to their work).  In the long run, consistency in a body of 
code greatly enhances its readability.

Peace?
Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

