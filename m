Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129201AbRBAOjC>; Thu, 1 Feb 2001 09:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129336AbRBAOix>; Thu, 1 Feb 2001 09:38:53 -0500
Received: from zeus.kernel.org ([209.10.41.242]:49874 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129201AbRBAOio>;
	Thu, 1 Feb 2001 09:38:44 -0500
Date: Thu, 1 Feb 2001 14:36:06 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, David Gould <dg@suse.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] vma limited swapin readahead
Message-ID: <20010201143606.P11607@redhat.com>
In-Reply-To: <20010201112601.K11607@redhat.com> <Pine.LNX.4.21.0102010824000.17822-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0102010824000.17822-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Thu, Feb 01, 2001 at 08:53:33AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 01, 2001 at 08:53:33AM -0200, Marcelo Tosatti wrote:
> 
> On Thu, 1 Feb 2001, Stephen C. Tweedie wrote:
> 
> If we're under free memory shortage, "unlucky" readaheads will be harmful.

I know, it's a balancing act.  But given that even one successful
readahead per read will halve the number of swapin seeks, the
performance loss due to the extra scavenging has got to be bad to
outweigh the benefit.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
