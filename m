Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272587AbRHaCHX>; Thu, 30 Aug 2001 22:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272585AbRHaCHO>; Thu, 30 Aug 2001 22:07:14 -0400
Received: from femail43.sdc1.sfba.home.com ([24.254.60.37]:38373 "EHLO
	femail43.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272587AbRHaCG7>; Thu, 30 Aug 2001 22:06:59 -0400
Message-ID: <3B8EF269.BF457C7F@home.com>
Date: Thu, 30 Aug 2001 22:11:53 -0400
From: John Kacur <jkacur@home.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-3 i586)
X-Accept-Language: en, ru, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Advice on Unsigned Types
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, the min/max discussion has been educational if nothing else.
There is very good book called "Expert C Programming - Deep C Secrets",
by Peter Van Der Linden. (with a picture of a fish on the cover.) He
discusses the changes from K&R to ANSI C and quotes from the ANSI C
manual on Characters and Integers (the integral promotions) and on Usual
Arithmetic Conversions. An example he uses to show a subtle bug that
might occur if one doesn't think about these issues, is when using
sizeof, which could be hidden away in a macro. sizeof returns an
unsigned value. If you compare a negative int to the result of a sizeof
operation, it could be converted to an unsigned int and yield a large
positive number.

The advice the author give on Unsigned Types is:
"Avoid unnecessary complexity by minimizing your use of unsigned types.
Specifically, don't use an unsigned type to represent a quantity just
because it will never be negative (e.g."age" or "national debt").
Use a signed type like int and you won't have to worry about boundary
cases in the detailed rules for promoting mixed types.
Only use unsigned types for bitfields or binary masks. Use casts in
expressions, to make all the operands signed or unsigned, so the
compiler does not have to choose the result type."

John Kacur
