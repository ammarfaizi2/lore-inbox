Return-Path: <linux-kernel-owner+w=401wt.eu-S1751080AbXACUF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbXACUF7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 15:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbXACUF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 15:05:59 -0500
Received: from sa7.bezeqint.net ([192.115.104.21]:33099 "EHLO sa7.bezeqint.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080AbXACUF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 15:05:58 -0500
From: Shlomi Fish <shlomif@iglu.org.il>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 2.6.20-rc3] qconf Search Dialog
Date: Wed, 3 Jan 2007 22:01:28 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200701031954.36440.shlomif@iglu.org.il> <20070103095422.f89a88e5.randy.dunlap@oracle.com>
In-Reply-To: <20070103095422.f89a88e5.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701032201.28384.shlomif@iglu.org.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 January 2007 19:54, Randy Dunlap wrote:
> On Wed, 3 Jan 2007 19:54:36 +0200 Shlomi Fish wrote:
> > Hi all!
> >
> > [ I'm not subscribed to this list so please CC me on your replies. ]
> >
> > This is a new version of the patch that adds a search dialog to the
> > kernel's "make xconfig" configuration applet.
>
> Would you just clarify one thing, please.
> xconfig already has a search dialog.  Does this one replace it
> or fix it or what?

Interesting. I didn't notice this search dialog before because its menu item 
was placed in the "File" menu, which is the wrong place for a find command 
(Which should be in an "Edit" or "Search" menu). I believe others have missed 
it as well. Also, it is possible it wasn't available when I wrote the 
preliminary version of the patch back in March.

Aside from that my search dialog has some advantages:

1. Full text search - if you search for "available" in File->Search you won't 
find anything. Searching for it in Edit->Find will find many things. I think 
File->Search only searches using the identifiers or at most also the title.

2. Regular expression search.

3. Displaying the results in a tree, with their context.

All that said, I don't mind merging my modifications into the existing code, 
or replacing it entirely.

Regards,

	Shlomi Fish

>
> Thanks.
>
> > Changes in this release include:
> >
> > 1. Implemented regular expression querying. The GUI includes an option
> > for a keywords based query, which is not supported yet.
> >
> > 2. Fixed the fact that the top categories in the QListView do not have a
> > visible
> > [+] sign next to them to expand them. (Albeit they are expanded upon a
> > double click).
> >
> > 3. Now resizing the dialog to a larger default size.
> >
> > To do is:
> >
> > 1. Make sure double clicking an end-item opens and highlights it in the
> > main application.
> >
> > 2. Eliminate the weird black-outlined rectangle that appears in the
> > top-left corner of the dialog.
> >
> > --------
> >
> > The patch was tested against kernel 2.6.20-rc3.

---------------------------------------------------------------------
Shlomi Fish      shlomif@iglu.org.il
Homepage:        http://www.shlomifish.org/

Chuck Norris wrote a complete Perl 6 implementation in a day but then
destroyed all evidence with his bare hands, so no one will know his secrets.
