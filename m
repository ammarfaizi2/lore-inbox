Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266409AbUBLN2T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 08:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266412AbUBLN2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 08:28:18 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:58099 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266409AbUBLN2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 08:28:14 -0500
Subject: Re: JFS default behavior (was: UTF-8 in file systems?
	xfs/extfs/etc.)
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040212004532.GB29952@hexapodia.org>
References: <20040209115852.GB877@schottelius.org>
	 <slrn-0.9.7.4-32556-23428-200402111736-tc@hexane.ssi.swin.edu.au>
	 <1076517309.21961.169.camel@shaggy.austin.ibm.com>
	 <20040212004532.GB29952@hexapodia.org>
Content-Type: text/plain
Message-Id: <1076592485.21961.191.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 12 Feb 2004 07:28:05 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-11 at 18:45, Andy Isaacson wrote:

> Why on earth is JFS worried about the filename, anyways?  Why has it
> *ever* had *any* behavior other than "string of bytes, delimited with /,
> terminated with \0" ?

The problem that was addressed in OS/2 was that one user using locale A
would create some files using non-ascii characters.  Then a user using
locale B would access these files, but the characters in those names did
not make sense in his locale.  Storing the file names in unicode allowed
the characters to always translate to the correct characters in the
user's locale, when the charset allowed it.  I'm not familiar enough
with the European locales to give specific examples.  It was never an
issue in the U.S. :^)

The OS/2 kernel has locale information for each process, so this
actually works very well there.  I will admit that it was a mistake not
to change the default behavior when we ported this to Linux.

> I read your response about OS/2, and maybe I'm just slow, but I don't
> see what that has to do with anything.
> 
> Does JFS on AIX have the same buggy behavior?

I know that JFS1 did not.  I'm not sure about JFS2, since it was ported
from the same OS/2 code base.

> What behavior was the code originally designed to implement, on OS/2?
> Why was that behavior chosen rather than "filenames are a string of
> bytes"?

I hope I explained that well enough above.

> Feel free to point to a "Design of the OS/2 JFS interface" document if
> such exists and answers my question. :)
> 
> -andy
-- 
David Kleikamp
IBM Linux Technology Center

