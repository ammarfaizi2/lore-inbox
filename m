Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135464AbRA0UqJ>; Sat, 27 Jan 2001 15:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135488AbRA0UqA>; Sat, 27 Jan 2001 15:46:00 -0500
Received: from zeus.kernel.org ([209.10.41.242]:28642 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135487AbRA0Upo>;
	Sat, 27 Jan 2001 15:45:44 -0500
Date: Sat, 27 Jan 2001 20:43:24 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Rodrigo Barbosa (aka morcego)" <rodrigob@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: Renaming lost+found
Message-ID: <20010127204324.B14943@redhat.com>
In-Reply-To: <20010126141350.Q6979@capsi.com> <Pine.LNX.3.95.1010126084632.208A-100000@chaos.analogic.com> <20010126131949.A1041@bessie.dyndns.org> <20010126180554.I19067@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010126180554.I19067@conectiva.com.br>; from rodrigob@conectiva.com.br on Fri, Jan 26, 2001 at 06:05:54PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 26, 2001 at 06:05:54PM -0200, Rodrigo Barbosa (aka morcego) wrote:
> 
> I think JFS indeed doesn't have it. And ReiserFS doesn't too. This 
> should be common place for journaling filesystems.

No, it's nothing to do with journaling or not.  Even journaling
filesystems can suffer IO errors or corrupt disk blocks, and any case
where you have a file whose name has been lost due to such corruption
needs to be dealt with by the fsck tool.  Traditionally, fsck puts
such files into lost+found, and in the presence of data corruption, it
will still need to do so even with a journaling filesystem.

ext3 uses lost+found in exactly the same way as ext2 for this reason.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
