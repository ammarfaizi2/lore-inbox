Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133024AbRBRQnl>; Sun, 18 Feb 2001 11:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133063AbRBRQnb>; Sun, 18 Feb 2001 11:43:31 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:39181 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S133024AbRBRQnL>; Sun, 18 Feb 2001 11:43:11 -0500
Date: Sun, 18 Feb 2001 11:42:55 -0500
From: Chris Mason <mason@suse.com>
To: Frank de Lange <frank@unternet.org>, linux-kernel@vger.kernel.org
cc: reiser@namesys.com
Subject: Re: reiserfs on 2.4.1,2.4.2-pre (with null bytes patch) breaks
 mozilla compile
Message-ID: <1304300000.982514575@tiny>
In-Reply-To: <20010218021050.A13823@unternet.org>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sunday, February 18, 2001 02:10:50 AM +0100 Frank de Lange
<frank@unternet.org> wrote:

>>  At least the patch didn't make it worse. Would anyone care to comment on
>>  how the elf-dynstr-gc option changes the file access patterns for the
>>  compile?
> 
> It does not change the file access patterns, it adds an extra step. A
> separate binary (dist/bin/elf-dynstr-gc, a convoluted version of strip)
> is run over the final (linked) library/executable to remove some symbol
> info. The elf-dynstr-gc program is compiled as part of the mozilla build.
> There's nothing wrong with elf-dynstr-gc on the reiserfs filesystem, it
> is identical to the one on the ext2 partition. Running the 'reiserfs'
> version on the ext2 tree works as it should, running the ext2 version on
> the reiserfs tree crashes (seems the program is not very robust, as it
> does not detect garbled input files). As said, running objdump on the
> corrupted (reiserfs compiled) library also produces errors.

Great, that will help narrow things down.  Please run the elf-dynstr-gc
program under strace, on top of both the ext2 and reiserfs trees, and send
the results (privately, they'll probably be large) to me.

-chris



