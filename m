Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVBLAjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVBLAjN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 19:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVBLAjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 19:39:13 -0500
Received: from relay.axxeo.de ([213.239.199.237]:8931 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S262316AbVBLAjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 19:39:10 -0500
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: Rik van Riel <riel@redhat.com>
Subject: Re: 2.6.11-rc3: Kylix application no longer works?
Date: Sat, 12 Feb 2005 01:39:01 +0100
User-Agent: KMail/1.7.1
Cc: Daniel Jacobowitz <dan@debian.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
References: <20050207221107.GA1369@elf.ucw.cz> <20050209153441.GA8809@nevyn.them.org> <Pine.LNX.4.61.0502091512430.2108@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0502091512430.2108@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502120139.01964.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rik van Riel wrote:
> On Wed, 9 Feb 2005, Daniel Jacobowitz wrote:
> > On Tue, Feb 08, 2005 at 06:10:18PM -0800, Andrew Morton wrote:
> > It's asking for a lot of unwritable zeroed space.  See this:
> >>   LOAD           0x000000 0x08048000 0x08048000 0xb7354 0x1b7354 R E
> >> 0x1000 LOAD           0x0b7354 0x08200354 0x08200354 0x1e3e4 0x1f648 RW 
> >> 0x1000
> >
> > clear_user's probably not the right way to provide the extra zeroing.
>
> Indeed, clear_user() refuses to zero data when it's not writable
> to the user process ...

So if the application wants an read only range of zeroed pages, why
not just map the ZERO_PAGE() multiple times there?

I can imagine _valid_ uses for that (templates for zero intitialized data),
although there are _better_ ways to do that.


Regards

Ingo Oeser

