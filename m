Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130834AbRBARUm>; Thu, 1 Feb 2001 12:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131005AbRBARUd>; Thu, 1 Feb 2001 12:20:33 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:32926 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S130834AbRBARU2>; Thu, 1 Feb 2001 12:20:28 -0500
Date: Thu, 1 Feb 2001 18:20:21 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, David Gould <dg@suse.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] vma limited swapin readahead
Message-ID: <20010201182021.N1173@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010201143606.P11607@redhat.com> <Pine.LNX.4.21.0102011441380.1321-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0102011441380.1321-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Thu, Feb 01, 2001 at 02:45:04PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 02:45:04PM -0200, Rik van Riel wrote:
> One solution could be to put (most of) the swapin readahead
> pages on the inactive_dirty list, so pressure by readahead
> on the resident pages is smaller and the not used readahead
> pages are reclaimed faster.

Shouldn't they be on inactive_clean anyway? They are not mapped
(if I read Stephens comment correctly) and are clean (because we
just read them in).

So if we have to put it there explicitly, we have at least a
performance bug, don't we?

Or do I still not get the new linux mm design? ;-(

Totally clueless

Ingo Oeser

PS: Who CC'ed is also subscribed to linux-mm? Or do we all filter
   dupes via "formail -D"? ;-)
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
