Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289320AbSAVV13>; Tue, 22 Jan 2002 16:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289316AbSAVV1T>; Tue, 22 Jan 2002 16:27:19 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:10257
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S289320AbSAVV1I>; Tue, 22 Jan 2002 16:27:08 -0500
Subject: Re: Possible Idea with filesystem buffering.
From: Shawn Starr <spstarr@sh0n.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Hans Reiser <reiser@namesys.com>, Chris Mason <mason@suse.com>,
        Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.33L.0201221910500.32617-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0201221910500.32617-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 22 Jan 2002 16:28:24 -0500
Message-Id: <1011734932.271.1.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've started on writing a pagebuf daemon (experimenting with ramfs). It
will have the VM manage the allocating/freeing of pages. The filesystem
should not have to know when a page needs to be freed or allocated. It
just need pages. The pagebuf is supposed to age pages not the
filesystem. 

Shawn.

On Tue, 2002-01-22 at 16:12, Rik van Riel wrote:
> On Tue, 22 Jan 2002, Hans Reiser wrote:
> 
> > Why does it need to know how suitable it is compared to the other
> > subcaches?  It just ages X pages,
> 
> How the hell is the filesystem supposed to age pages ?
> 
> The filesystem DOES NOT KNOW how often pages are used,
> so it cannot age the pages.
> 
> End of thread.
> 
> Rik
> -- 
> "Linux holds advantages over the single-vendor commercial OS"
>     -- Microsoft's "Competing with Linux" document
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


