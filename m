Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268193AbUH3Odf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268193AbUH3Odf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 10:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268174AbUH3Ode
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 10:33:34 -0400
Received: from srv1-1.itssrv.com ([143.199.124.13]:34758 "EHLO
	srv1-1.itssrv.com") by vger.kernel.org with ESMTP id S268163AbUH3OdL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 10:33:11 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
Subject: reiser4 semantics / BeFS Architect(s) Query Resolution
Date: Mon, 30 Aug 2004 08:32:55 -0600
Message-ID: <3DF9165145FACB4C96977FF650C1E9040C46A3D1@its-mail1.its.corp.gwl.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: reiser4 semantics / BeFS Architect(s) Query Resolution
Thread-Index: AcSM5Rws31ypFZsORomhdV8gFTXI6QBraHCw
From: "Burnes, James" <james.burnes@gwl.com>
To: "Hans Reiser" <reiser@namesys.com>, "Will Dyson" <will_dyson@pobox.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <torvalds@osdl.org>, <reiserfs-list@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(comments below)

> -----Original Message-----
> From: Hans Reiser [mailto:reiser@namesys.com]
> Sent: Saturday, August 28, 2004 3:55 AM
> To: Will Dyson
> Cc: Andrew Morton; hch@lst.de; linux-fsdevel@vger.kernel.org; linux-
> kernel@vger.kernel.org; flx@namesys.com; torvalds@osdl.org; reiserfs-
> list@namesys.com
> Subject: Re: silent semantic changes with reiser4
> 
> I think there are two ways to analyze the code boundary issue.  One is
> "does it belong in the kernel?"  Another is, "does it belong in the
> filesystem. and if so should name resolution in a filesystem be split
> into two parts, one in kernel, and one in user space."  In ten years I
> might have the knowledge needed to make such a split, but I know for
> sure that I don't know how to do it today without regretting it
> tomorrow, and I don't really have confidence that I will ever be able
to
> do it without losing performance.
> 
> Glad that BeFS finds the new model better.:)
>

(glad that BeFS supposedly solved it)

> 
> > Hans Reiser wrote:
> >
> >> Will Dyson wrote:
> >>
> >>>
> >>> In the original BeOS, they solved the problem by having the
> >>> filesystem driver itself take a text query string and parse it,
> >>> returning a list of inodes that match. The whole business of
parsing
> >>> a query string in the kernel (let alone in the filesystem driver)
> >>> has always seemed ugly to me.
> >>
> >>
> >> Why?
> >

Here is an interesting interview of Dominic Giampaolo and Benoit
Schillings regarding the structure of BeFS.  Some interesting issues
regarding how queries were done.

http://www.theregister.co.uk/2002/03/29/windows_on_a_database_sliced/

BTW: I get paid during the day to do security engineering work.
Wouldn't parsing the query in the kernel make the kernel susceptible to
buffer overflows?  Bad place to have an overflow.

j.burnes

