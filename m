Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRADDln>; Wed, 3 Jan 2001 22:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132116AbRADDld>; Wed, 3 Jan 2001 22:41:33 -0500
Received: from zeus.kernel.org ([209.10.41.242]:41489 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129324AbRADDlT>;
	Wed, 3 Jan 2001 22:41:19 -0500
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Dan Aloni <karrde@callisto.yi.org>
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking bug exploits
In-Reply-To: <Pine.LNX.4.21.0101032259550.20246-100000@callisto.yi.org> <87hf3gj94q.fsf@monolith.cepstral.com> <20010104043244.A16413@gruyere.muc.suse.de>
From: David Huggins-Daines <dhd@eradicator.org>
Organization: None worth mentioning
Date: 03 Jan 2001 22:41:05 -0500
In-Reply-To: Andi Kleen's message of "Thu, 4 Jan 2001 04:32:44 +0100"
Message-ID: <87d7e4j86m.fsf@monolith.cepstral.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Wed, Jan 03, 2001 at 10:20:37PM -0500, David Huggins-Daines wrote:
> > Dan Aloni <karrde@callisto.yi.org> writes:
> > 
> > > This preliminary, small patch prevents execution of system calls which
> > > were executed from a writable segment.
> > 
> > How does signal return work, then?
> 
> Newer glibc sets a sa_restorer.

Hmm, maybe sigaction(2) should stop documenting it as "obsolete and
should not be used" then :-)

-- 
David Huggins-Daines		-		dhd@eradicator.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
