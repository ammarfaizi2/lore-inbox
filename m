Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264729AbUENGj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264729AbUENGj0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 02:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbUENGj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 02:39:26 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:19676 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264316AbUENGjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 02:39:24 -0400
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilites, take 2
References: <200405131308.40477.luto@myrealbox.com>
	<20040513182010.L21045@build.pdx.osdl.net>
	<40A42E8E.4030603@myrealbox.com>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Fri, 14 May 2004 08:39:12 +0200
In-Reply-To: <40A42E8E.4030603@myrealbox.com> (Andy Lutomirski's message of
 "Thu, 13 May 2004 19:27:26 -0700")
Message-ID: <87zn8bzf5b.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@myrealbox.com> writes:

> I'm not convinced that Posix's version makes any sense.  Also, there are
> apparently a number of drafts around which disagree on what the right
> rules are.  (My copy, for example, matches the old rules exactly, but
> the old rules caused the sendmail problem.)

Don't confuse POSIX _semantics_ with implementation _bugs_.

>  And, under Posix, what does
> the inheritable mask mean, anyway?
>
> Also, I don't find the posix rules to be useful (why is there an
> inheritable mask if all it does is to cause caps to be dropped on
> exec, when the user could just manually drop them?).

You can use the inheritable set, if you want to give capabilities to a
process when it's started by an already priviledged parent (e.g. a
root process), but not when it's started by a regular user.

See <http://www.olafdietsche.de/linux/capability/> for an example.

Regards, Olaf.
