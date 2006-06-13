Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932905AbWFMFxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932905AbWFMFxu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 01:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932907AbWFMFxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 01:53:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:33987 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932905AbWFMFxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 01:53:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rv76+YgKqv1kYgmnFdvMo2rXiS4SrECOGWEaKZdArKXQxKWV+agV4AdbDgahvgaiiHAsro+rJs1yDdlMpcLughTPI8DtwihohbPQZ9kheakF9OfgCkXNsT58GpbGGlojYYlHp4hDutIWmYkO/Hsj5HlAedMnKAPMSgjGou7S30o=
Message-ID: <787b0d920606122253o4f1a9e18x1ca49c3ce005696f@mail.gmail.com>
Date: Tue, 13 Jun 2006 01:53:48 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org, ak@suse.de, rohitseth@google.com,
       akpm@osdl.org, Linux-mm@kvack.org, arjan@infradead.org,
       jengelh@linux01.gwdg.de
Subject: Re: [PATCH]: Adding a counter in vma to indicate the number of physical_pages_backing it
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting two different people:

> BTW, what is smaps used for (who uses it), anyway?
...
> smaps is only a debugging kludge anyways and it's
> not a good idea to we bloat core data structures for it.

I'd be using it in procps for the pmap command if it
were not so horribly nasty. I may eventually get around
to using it, but maybe it's just too gross to tolerate.
That mess should never have slipped into the kernel.
Just take a look at /proc/self/smaps some time. Wow.

A month or two ago I supplied a patch to replace smaps
with something sanely parsable. I was essentially told
that we already have this lovely smaps dungheap that I
should just use, but a couple people were eager to see
the patch go in.

Anyway, I need smaps stuff plus info about locked memory
and page sizes. Solaris provides this. People seem to
like it. I guess it's for performance tuning of app code or
maybe for scalibility predictions.
