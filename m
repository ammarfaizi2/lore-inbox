Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbULBKqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbULBKqI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 05:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbULBKqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 05:46:08 -0500
Received: from gate.firmix.at ([80.109.18.208]:1932 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S261555AbULBKqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 05:46:03 -0500
Subject: Re: What if?
From: Bernd Petrovitsch <bernd@firmix.at>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1101976424l.5095l.0l@werewolf.able.es>
References: <41AE5BF8.3040100@gmail.com> <20041202044034.GA8602@thunk.org>
	 <1101976424l.5095l.0l@werewolf.able.es>
Content-Type: text/plain
Organization: Firmix Software GmbH
Message-Id: <1101984361.28965.10.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Thu, 02 Dec 2004 11:46:01 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-02 at 08:33 +0000, J.A. Magallon wrote:
[...]
> Constructor/destuctor is needed, and also virtual single inheritance.
> And those two things are already being done by hand with function
> pointers inside structs in the kernel. The cost of (single and multiple)
> inheritance in C++ is also just an indexed jump, the difference is that
> in the pseudo object oriented things done in the kernel you have to

If software is object-oriented is a question of design, not the
implementation language. So it is neither necessary nor sufficient to
use a (so called) "object-oriented language" to get (or not get)
OO-software.

> always initializa the funtions pointers, and C++ will do it for you.
> How many bugs have you seen because somebody wrote a bad
> .method = the wrong_func in an initializer ?

You like putting the "read" function into the place of the "open"
function in a struct file_operations?
If you name your functions meaningful, you probably see it at the time
you write the code.
And if you do not see it during coding, you probably will see it on the
very first test run.
So the effect is at most moving initialization code and logic from a
the .c in a .h file?!

The unanswered question is: What does it actually buy?

Exceptions, STL, and most of the fancy features are not usable and must
be thrown out (you even have to forbid them and look after it).
The holds - more or less - for operator overloading (except in very few
cases).
So the usual C++-(and OO-) marketing propaganda does not help since most
features (including all standard run-time libs) are either not usable or
forbidden.
Yes, you get probably stricter type checking - most of this is in C also
doable.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

