Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263042AbSJGOLA>; Mon, 7 Oct 2002 10:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263054AbSJGOLA>; Mon, 7 Oct 2002 10:11:00 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:51216 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263042AbSJGOK7>; Mon, 7 Oct 2002 10:10:59 -0400
Date: Mon, 7 Oct 2002 15:16:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: bcopy()
Message-ID: <20021007151605.A11001@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <12660.1033999032@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <12660.1033999032@warthog.cambridge.redhat.com>; from dhowells@redhat.com on Mon, Oct 07, 2002 at 02:57:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 02:57:12PM +0100, David Howells wrote:
> 
> Hi Linus,
> 
> The implementation of bcopy() in lib/string.c (and some other places such as
> the XFS header files) is incorrect as it implements bcopy as memcpy. This is
> wrong: bcopy should be the equivalent of memmove (which handles overlapping
> areas correctly).

Kernel bcopy in traditional unix versions never supported overlapping.
That's what ovbcopy() is/was for.
