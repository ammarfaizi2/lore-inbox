Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269336AbRGaP7v>; Tue, 31 Jul 2001 11:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269331AbRGaP7f>; Tue, 31 Jul 2001 11:59:35 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:27411
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S269335AbRGaP7U>; Tue, 31 Jul 2001 11:59:20 -0400
Date: Tue, 31 Jul 2001 11:58:09 -0400
From: Chris Mason <mason@suse.com>
To: Chris Wedgwood <cw@f00f.org>
cc: Hans Reiser <reiser@namesys.com>, Rik van Riel <riel@conectiva.com.br>,
        Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <108130000.996595089@tiny>
In-Reply-To: <20010801031554.B7728@weta.f00f.org>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Wednesday, August 01, 2001 03:15:54 AM +1200 Chris Wedgwood <cw@f00f.org>
wrote:

> On Tue, Jul 31, 2001 at 09:41:25AM -0400, Chris Mason wrote:
> 
>     if (some_error) {
>     #ifdef CONFIG_REISERFS_CHECK
>         panic("some_error") ;
>     #else
>         gracefully_recover
>     #endif
> 
> What a terrible construct... if would be much more elegant as:
> 
>         if(some_error) {
>                 _namesys_internal_foo("some_error");
>                 recover_bar();
>         }
> 
> where _namesys_internal_foo is compiled differently and may not return
> depending on CONFIG_REISERFS_CHECK and maybe also the error type.

Two part answer...

1) almost none of the CONFIG_REISERFS_CHECKs look like that, it was an
oversimplified example ;-)

2) Even still, the #ifdefs look nasty, and make the code hard to read.  Take
a look at the latest ac release, which has a patch from Nikita that is
similar to what you describe.

-chris



