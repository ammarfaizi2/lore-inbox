Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbSJFJog>; Sun, 6 Oct 2002 05:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263367AbSJFJog>; Sun, 6 Oct 2002 05:44:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36356 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263366AbSJFJof>; Sun, 6 Oct 2002 05:44:35 -0400
Date: Sun, 6 Oct 2002 10:50:08 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Joseph D. Wagner" <wagnerjd@prodigy.net>
Cc: Linux Kernel Development List <linux-kernel@vger.kernel.org>
Subject: Re: Good Idea (tm): Code Consolidation for Functions and Macros that Access the Process Address Space
Message-ID: <20021006105008.B27487@flint.arm.linux.org.uk>
References: <000001c26cd3$950ef580$7975d73f@joe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <000001c26cd3$950ef580$7975d73f@joe>; from wagnerjd@prodigy.net on Sat, Oct 05, 2002 at 07:58:55PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2002 at 07:58:55PM -0500, Joseph D. Wagner wrote:
> SUBJECT: Good Idea (tm): Code Consolidation for Functions and Macros
> that Access the Process Address Space
>...
> Remember, if a function call has no place for a returned value to go,
> nothing bad happens; the returned value is simply ignored/discarded.

And the compiler warning?

> SOLUTION:

Get rid of the _ret forms.  Their use is frowned on today anyway because
they hide the real meaning of what the code is trying to do, and hiding
the fact that a function can return in the middle of what looks like a
macro call is _REAL_ _BAD_.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

