Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269223AbTGJLrW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 07:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269224AbTGJLrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 07:47:21 -0400
Received: from ns.suse.de ([213.95.15.193]:37392 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269223AbTGJLrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 07:47:17 -0400
To: Oleg Drokin <green@namesys.com>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>,
       "\"Nikita Danilov\" " <Nikita@Namesys.COM>,
       linux-kernel@vger.kernel.org
Subject: Re: Are "," and ".." in directory required?
References: <16141.14720.980604.428130@laputa.namesys.com>
	<E19aYWH-00075R-00.arvidjaar-mail-ru@f25.mail.ru>
	<20030710104145.GA2858@namesys.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: All I can think of is a platter of organic PRUNE CRISPS being
 trampled
 by an army of swarthy, Italian LOUNGE SINGERS...
Date: Thu, 10 Jul 2003 14:01:55 +0200
In-Reply-To: <20030710104145.GA2858@namesys.com> (Oleg Drokin's message of
 "Thu, 10 Jul 2003 14:41:45 +0400")
Message-ID: <je65maio98.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin <green@namesys.com> writes:

|> Hello!
|> 
|> On Thu, Jul 10, 2003 at 02:19:21PM +0400, "Andrey Borzenkov"  wrote:
|> > > Enter empty directory. Remove it by rmdir() by another process. Now you
|> > > have a directory without dot and dotdot.
|> > It is not quite the same.
|> > bor@itsrm2% cd foo
|> > bor@itsrm2% sudo rmdir /tmp/foo

No need for sudo.

|> > bor@itsrm2% ls -la .
|> > .: No such file or directory
|> 
|> Well, this sequence of events is wrong.
|> You need to open it first, then remove it, and then do readdir (you still have filehandle to it).

The filehandle is implicit (by being a cwd).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
