Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290220AbSAXACg>; Wed, 23 Jan 2002 19:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290223AbSAXACP>; Wed, 23 Jan 2002 19:02:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4879 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290220AbSAXACE>;
	Wed, 23 Jan 2002 19:02:04 -0500
Message-ID: <3C4F4EE8.C79C0CC9@mandrakesoft.com>
Date: Wed, 23 Jan 2002 19:01:44 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: "Stephen C. Tweedie" <sct@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        Hans Reiser <reiser@namesys.com>,
        Andreas Dilger <adilger@turbolabs.com>, Chris Mason <mason@suse.com>,
        Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.21.0201232350280.2148-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> On Wed, 23 Jan 2002, Stephen C. Tweedie wrote:
> >
> > This is actually really important --- writepage on its own cannot
> > distinguish between requests to flush something to disk (eg. msync or
> > fsync), and requests to evict dirty data from memory.
> 
> Actually, that much can now be distinguished:
>  PageLaunder(page) when evicting from memory,
> !PageLaunder(page) when msync or fsync.

Nifty!  Thanks for pointing this out.

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
