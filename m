Return-Path: <linux-kernel-owner+w=401wt.eu-S932401AbXAGF0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbXAGF0M (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 00:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbXAGF0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 00:26:12 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47064 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932401AbXAGF0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 00:26:12 -0500
Message-ID: <45A0846A.4020603@garzik.org>
Date: Sun, 07 Jan 2007 00:26:02 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Denis Vlasenko <vda.linux@googlemail.com>,
       Albert Cahalan <acahalan@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk, bunk@stusta.de,
       mikpe@it.uu.se
Subject: Re: kernel + gcc 4.1 = several problems
References: <787b0d920701032311l2c37c248s3a97daf111fe88f3@mail.gmail.com> <787b0d920701040904i553e521fsb290acf5059f0b62@mail.gmail.com> <Pine.LNX.4.64.0701040921010.3661@woody.osdl.org> <200701070525.45974.vda.linux@googlemail.com> <Pine.LNX.4.64.0701062041330.3661@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701062041330.3661@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> (That said, I think __builtin_memcpy() does a reasonable job these days 
> with gcc, and we might drop the crap one day when we can trust the 
> compiler to do ok. It didn't use to, and we continued using our 
> ridiculous macro/__builtin_constant_p misuses just because it works with 
> _all_ relevant gcc versions).


Yep, a ton of work by Roger Sayle, among others, really matured the gcc 
str*/mem* builtins in the 4.x series.  They are definitely worth another 
look.

	Jeff


