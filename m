Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262003AbTDADO0>; Mon, 31 Mar 2003 22:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262005AbTDADO0>; Mon, 31 Mar 2003 22:14:26 -0500
Received: from web20002.mail.yahoo.com ([216.136.225.47]:49536 "HELO
	web20002.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262003AbTDADOZ>; Mon, 31 Mar 2003 22:14:25 -0500
Message-ID: <20030401032546.17891.qmail@web20002.mail.yahoo.com>
Date: Mon, 31 Mar 2003 19:25:46 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: mmap-related questions
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030331125548.D20730@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Benjamin LaHaise <bcrl@redhat.com> wrote:
> No.  You must use msync().

> Note that fsync() after
> munmap() will flush the 
> pages to disk under Linux.
Sweet!  Paydirt!  Is this documented/guaranteed to
continue to work for a while?
Is this true for all non-mmap()ed dirty buffers for a
given file?

Just to restate what you said:
- if part of a file is mmap()ed, msync() MUST be used
to sync it.
- any non-mmap()ed portions are synched with fsync().

I'm assuming this is a per-process thing.  i.e. The
above is true regardless of what other processes are
doing (e.g. even if another process has the same file
mmap()'d, I don't care).

> 2.4.7 is way out of date and should be updated for
> the numerous bugfixes and 
> security errata.
I know.  Unfortunately not my call.  Desperately
trying to beat people with clue sticks....

Thanks!,
-Kenny

__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online, calculators, forms, and more
http://platinum.yahoo.com
