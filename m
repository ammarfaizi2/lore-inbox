Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269500AbUICBMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269500AbUICBMo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269478AbUICBMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 21:12:35 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:2764 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269500AbUICA5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:57:21 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org>
	<200408282314.i7SNErYv003270@localhost.localdomain>
	<20040901200806.GC31934@mail.shareable.org>
	<Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
	<1094118362.4847.23.camel@localhost.localdomain>
	<Pine.LNX.4.58.0409021045210.2295@ppc970.osdl.org>
	<20040902175034.GA18861@lst.de>
	<Pine.LNX.4.58.0409021059230.2295@ppc970.osdl.org>
From: Linh Dang <linhd@nortelnetworks.com>
Organization: Null
Date: Thu, 02 Sep 2004 20:57:14 -0400
In-Reply-To: <Pine.LNX.4.58.0409021059230.2295@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 2 Sep 2004 11:03:52 -0700 (PDT)")
Message-ID: <wn5k6vc6ufp.fsf@linhd-2.ca.nortel.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

>
>
> On Thu, 2 Sep 2004, Christoph Hellwig wrote:
>>
>> http://oss.oracle.com/projects/userfs/ has code that clues gnomevfs
>> onto a kernel filesystem.  The code is horrible, but it shows that
>> it can be done.
>
> I do like the setup where the extended features are done as a "view"
> on top of some other filesystem, so that you can choose to _either_
> access the raw (and supposedly stable, simply by virtue of
> simplicity) or the "fancy" interface. Without having to reformat the
> disk to a filesystem you don't trust, or you have other reasons you
> can't use (disk sharing with other systems, whatever).

It'd be something similar to what clearcase does (not that I like
clearcase, I hate it with a passion for other reasons!)

On such a system, one would have multiple virtual views mounted (by
root) under:

        /view/tar, /view/dpkg, /view/rpm, etc.

for every regular file /home/joe/blah.tar

the path /view/tar/home/joe/blah.tar/ is a directory where member of
the archives directly accessible.

old tools continue work as is. new tools can take a look on virtual
views for virtual access. 

Not sure how such a system would work with the dentry cache.

-- 
Linh Dang
