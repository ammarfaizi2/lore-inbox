Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268836AbUHZNiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268836AbUHZNiE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 09:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268824AbUHZNiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 09:38:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54405 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268776AbUHZNh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 09:37:59 -0400
Date: Thu, 26 Aug 2004 09:36:26 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Spam <spam@tnonline.net>, <wichert@wiggy.net>, <jra@samba.org>,
       <torvalds@osdl.org>, <reiser@namesys.com>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040826024956.08b66b46.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0408260935130.26316-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Andrew Morton wrote:

> All of which can be handled in userspace library code.
> 
> What compelling reason is there for doing this in the kernel?

There's a compelling reason to do it in userspace.  If an
unaware program copies or moves such a file with streams
inside, it doesn't break the streams and aware programs will
continue to see them.

OTOH, if we had the streams in the kernel, unaware applications
would continuously break the metadata and streams that the
streams aware programs expect !

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

