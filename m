Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131527AbRAVQK3>; Mon, 22 Jan 2001 11:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132178AbRAVQKT>; Mon, 22 Jan 2001 11:10:19 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:12296 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131527AbRAVQKG>; Mon, 22 Jan 2001 11:10:06 -0500
To: Bernd Eckenfels <lists@lina.inka.de>
Cc: linux-kernel@vger.kernel.org, debian-devel@lists.debian.org
Subject: Re: the remount problem [2.4.0] kind of solved [patch]
In-Reply-To: <20010121130745.A1383@lina.inka.de>
	<87snmcl31k.fsf@mose.informatik.uni-tuebingen.de>
	<20010122093234.A9194@lina.inka.de>
From: Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>
Date: 22 Jan 2001 17:09:44 +0100
In-Reply-To: Bernd Eckenfels's message of "Mon, 22 Jan 2001 09:32:34 +0100"
Message-ID: <87vgr78t6f.fsf@mose.informatik.uni-tuebingen.de>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Bernd Eckenfels <lists@lina.inka.de> writes:
    >> Why in hell are library open for write? But it doesn't seem to
    >> be only libraries:

     > They are not open for write. They are open for mmaped read. The
     > Problem with this is, that as long as the files are open, the
     > filesystem cannot remove them from disk. This means, that as
     > long as you have files open, even for read, which are deleted,
     > a remount ro will fail.

     > The new lsof will find those mmaped files, so you can simply
     > restart the associated binary.

Ah, I see. Forgot about that.

Maybe the kernel coud swap in the deleted libraries and keep it in
memory or real swap from then on instead of blocking the fs.

     > Yes, all daemons will get started with the old libs, since a
     > upgrade always happens after system start :) But not only
     > daemons. Think of Shells, getty, login, ...

So, when you update glibc, / can't be remounted ro any more?
Ugly.

MfG
        Goswin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
