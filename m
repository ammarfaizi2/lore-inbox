Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTFBKkf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 06:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbTFBKkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 06:40:35 -0400
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:48428 "EHLO
	mail.trasno.org") by vger.kernel.org with ESMTP id S262161AbTFBKkd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 06:40:33 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Steven Cole <elenstev@mesatop.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
References: <Pine.LNX.4.44.0305301414210.2671-100000@home.transmeta.com>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <Pine.LNX.4.44.0305301414210.2671-100000@home.transmeta.com>
Date: 02 Jun 2003 12:53:30 +0200
Message-ID: <m2smqs7nth.fsf@neno.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "linus" == Linus Torvalds <torvalds@transmeta.com> writes:

linus> On Fri, 30 May 2003, Russell King wrote:
>> 
>> On Fri, May 30, 2003 at 01:57:13PM -0600, Steven Cole wrote:
>> > +int foo(
>> > +	long bar,
>> > +	long day,
>> > +	struct magic *xyzzy
>> > +)
>> 
>> Is this really part of the kernel coding style?

linus> No, but it's better than what it used to be.

linus> Also, while I don't think we should try to maintain 1:1 behaviour with 
linus> the _worst_ offenses of zlib, I do think we should maintain comments etc, 
linus> and a lot of the zlib function declarations used to look like

linus> int foo(bar, baz)
linus> long bar;		/* number of frobnicators */
linus> long baz;		/* self-larting on or off */
linus> {
linus> ....

linus> and the ANSI-fication changes this to

linus> int foo(
linus> long bar,	/* number of frobnicators */
linus> long baz	/* self-larting on or off */
linus> )
linus> {
linus> ...

linus> which while not according to the coding-standard is at least a reasonable 
linus> compromize between having proper C function definitions and keeping the 
linus> code _looking_ more like the original.

Once there:


/**
 * foo - <put something there>
 * @bar: number of frobnicators
 * @baz: self-larting on or off
 * @userdata: pointer to arbitrary userdata to be registered
 *
 * Description: Please, fix me
 */
int foo(long bar, long baz)
{
...

Looks like a better alternative to me.

YMMV, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
