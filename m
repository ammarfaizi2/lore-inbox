Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279908AbRJ3KMl>; Tue, 30 Oct 2001 05:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279909AbRJ3KMb>; Tue, 30 Oct 2001 05:12:31 -0500
Received: from euston.inpharmatica.co.uk ([193.115.214.6]:25552 "EHLO
	sunsvr03.inpharmatica.co.uk") by vger.kernel.org with ESMTP
	id <S279908AbRJ3KMU>; Tue, 30 Oct 2001 05:12:20 -0500
Message-ID: <3BDE7D22.8000006@purplet.demon.co.uk>
Date: Tue, 30 Oct 2001 10:12:50 +0000
From: Mike Jagdis <jaggy@purplet.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, fr, de
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall exports - against 2.4.14-pre3
In-Reply-To: <20011029173711.B24272@caldera.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> Hi Linus,
> 
> once again the syscall export patch - back to EXPORT_SYMBOL
> vs EXPORT_SYMBOL_GPL due to some complaints, more syscalls
> as I dropped sys_call_table abuse in linux-abi.

The whole *point* of the sys_call_table "abuse" was to avoid having
the whole damn lot in the export list!

As a side effect it meant that any module that patched the
sys_call_table (funky tracers, security hot-fixes, whatever)
would work seamlessly with non-Linux binaries.

> Could you _please_ apply it - it is badly needed for foreign
> personalities compiled as modules.

I can't see why? iBCS always was a module for years before
linux-abi dumped it back in a humungous kernel patch.

				Mike

