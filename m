Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLWQTi>; Sat, 23 Dec 2000 11:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129535AbQLWQT2>; Sat, 23 Dec 2000 11:19:28 -0500
Received: from hermes.mixx.net ([212.84.196.2]:20494 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129340AbQLWQTS>;
	Sat, 23 Dec 2000 11:19:18 -0500
Message-ID: <3A44C8F7.53BB069D@innominate.de>
Date: Sat, 23 Dec 2000 16:47:03 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <Pine.LNX.4.21.0012221730270.3382-100000@freak.distro.conectiva> <84320000.977527131@coffee>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> It is enough to leave buffer heads we don't flush on the dirty list (and
> redirty the page), they'll get written by a future loop through
> flush_dirty_pages, or by page_launder.  We could use ll_rw_block instead,
> even though anon pages do have a writepage with this patch (just check if
> page->mapping == &anon_space_mapping).

anon_space_mapping... this is really useful.  This would make a nice
patch on its own.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
