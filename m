Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVBBAQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVBBAQQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 19:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVBBAQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 19:16:16 -0500
Received: from thunk.org ([69.25.196.29]:46242 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262187AbVBBAQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 19:16:09 -0500
Date: Tue, 1 Feb 2005 19:15:49 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Peter Busser <busser@m-privacy.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Message-ID: <20050202001549.GA17689@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Peter Busser <busser@m-privacy.de>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org
References: <200501311015.20964.arjan@infradead.org> <200501311357.59630.busser@m-privacy.de> <1107189699.4221.124.camel@laptopd505.fenrus.org> <200502011044.39259.busser@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502011044.39259.busser@m-privacy.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 10:44:39AM +0100, Peter Busser wrote:
> Again, this is a *simulation* of the way real-life applications could interact 
> with the underlying system. Again people complained that the results shown 
> were not accurate. And that has been fixed.
> 
> I am well aware of complaints by some people about this behaviour. That is why 
> there is a separated kiddie and blackhat mode in the latest PaXtest version. 
> The kiddie mode is for those people who prefer to feel warm and cozy and the 
> blackhat mode is for those who want to find out what the worst-case behaviour 
> is. So if you don't like the blackhat results, don't run that test!

Umm, so exactly how many applications use multithreading (or otherwise
trigger the GLIBC mprotect call), and how many applications use nested
functions (which is not ANSI C compliant, and as a result, very rare)?

Do the tests both ways, and document when the dummy() re-entrant
function might actually be hit in real life, and then maybe people
won't feel that you are deliberately and unfairly overstating things
to try to root for one security approach versus another.  Of course,
with name like "paxtest", maybe its only goal was propganda for the
PaX way of doing things, in which case, that's fine.  But if you want
it to be viewed as an honest, fair, and unbaised, then make it very
clear in the test results how programs with and without nested
functions, and with and without multithreading, would actually behave.

Or are you afraid that someone might then say --- oh, so PaX's extra
complexity is only needed if we care about programs that use nested
functions --- yawn, I think we'll pass on the complexity.  Is that a
tradeoff that you're afraid to allow people to make with full
knowledge?

						- Ted
