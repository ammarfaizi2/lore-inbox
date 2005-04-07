Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVDGJlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVDGJlB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 05:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbVDGJlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 05:41:01 -0400
Received: from webapps.arcom.com ([194.200.159.168]:47377 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S262313AbVDGJkw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 05:40:52 -0400
Message-ID: <42550023.6020205@cantab.net>
Date: Thu, 07 Apr 2005 10:40:51 +0100
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>	<1112858331.6924.17.camel@localhost.localdomain> <20050407015019.4563afe0.akpm@osdl.org>
In-Reply-To: <20050407015019.4563afe0.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2005 09:47:48.0359 (UTC) FILETIME=[DB5F0170:01C53B56]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> David Woodhouse <dwmw2@infradead.org> wrote:
> 
>> One feature I'd want to see in a replacement version control system is
>> the ability to _re-order_ patches, and to cherry-pick patches from my
>> tree to be sent onwards.
> 
> You just described quilt & patch-scripts.
> 
> The problem with those is letting other people get access to it.  I guess
> that could be fixed with a bit of scripting and rsyncing.

Where I work we've been using quilt for a while now and storing the
patch-set in CVS.  To limit the number of potential stuff-ups due to two
people working on the same patch at the same time (the chance that CVS's
merge will get it right is zero) we use CVS's locking feature to ensure
that only one person can edit/update a patch or the series file at any
one time.  It seems to work quite well (though admittedly there's only
two developers working on the patch-set and it currently contains a mere
61 patches).

We also have a few scripts to ensure we always due the correct locking.
 The main ones are:

qec -- to edit a file either as part of the top 'working' patch or as an
existing patch.  It does the quilt push which I always forget to do
otherwise.

qrefr -- like quilt refresh only it locks the patch first.

qimport -- like quilt import only it locks the series file first.

You can grab a tarball of these (and other, less interesting ones) from

http://www.davidvrabel.org.uk/quilt-n-cvs-scripts-1.tar.gz

Note that I'm providing this purely on an as-is basis in case any one is
interested.

And I've just realized I can't remember how exactly to set up the CVS
repository of the patch-set.  I think you need to do a cvs watch on when
it's checked-out.

David Vrabel
