Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbTBJX4n>; Mon, 10 Feb 2003 18:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbTBJX4n>; Mon, 10 Feb 2003 18:56:43 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:53666 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP
	id <S265711AbTBJX4n>; Mon, 10 Feb 2003 18:56:43 -0500
Date: Tue, 11 Feb 2003 13:07:14 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: extra PG_* bits for page->flags
In-reply-to: <20030210151244.7e42d3fb.akpm@digeo.com>
To: Andrew Morton <akpm@digeo.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
       jgarzik@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1044922034.4866.14.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20459.1044874267@warthog.cambridge.redhat.com>
 <20030210151244.7e42d3fb.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-11 at 12:12, Andrew Morton wrote:
> David Howells <dhowells@redhat.com> wrote:
> >  (*) PG_journal
> >  (*) PG_journalmark
> 
> Well.  If you new fs goes in then yes, we can spare those bits (just).

May I ask, how many bits do you consider available? swsusp beta 18 (ie
2.4), which I'm beginning to port to 2.5, uses 4 bits during suspend &
resume for various purposes. If I understand the code correctly, the
zone flags use bits 24-31 (although there has been that thread saying
they could use less bits). I see in the 2.5.60 patch bit 19 is now in
use. Should I be using private, temporarily allocated bitmaps instead of
the page flags, to ease the pressure? (Especially since the suspend code
is not used in 'normal' operation anyway).

Regards,

Nigel


