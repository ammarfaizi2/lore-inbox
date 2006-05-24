Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWEXUIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWEXUIj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 16:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWEXUIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 16:08:39 -0400
Received: from nevyn.them.org ([66.93.172.17]:6590 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S932251AbWEXUIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 16:08:38 -0400
Date: Wed, 24 May 2006 16:08:37 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: vamsi krishna <vamsi.krishnak@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Program to convert core file to executable.
Message-ID: <20060524200837.GA5679@nevyn.them.org>
Mail-Followup-To: vamsi krishna <vamsi.krishnak@gmail.com>,
	linux-kernel@vger.kernel.org
References: <3faf05680605241018q302d5c0em6844765f81669498@mail.gmail.com> <20060524173821.GA1292@nevyn.them.org> <3faf05680605241306t64f63225i4d25af3e92a9d9f9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3faf05680605241306t64f63225i4d25af3e92a9d9f9@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 01:36:08AM +0530, vamsi krishna wrote:
> o Does the other PHDRS for which FileSiz is zero correspond to the
> dynamic shared objects (.so) text ?? example in the above we see (2
> **ed ) PHDR with VirtAddr as 0xf649c000 , so this means the text of
> some shared .so has been mapped here right?

Probably.

> o I have question about the memory mapping with permissions r--s or
> r--p (gconv used by glibc gets mapped like this some time) , so does
> the core file contains this information of the memory mappings?
> 
> o Is there a way I can findout the standard which the OS follows to
> write the core file?

No.  Core files change from time to time.  David Miller recently
proposed changing these.

> o Rather than depending on the OS core file, hows your opinion on
> writing out all the mappings form /proc/<pid>/maps as PT_LOAD into a
> elf formatted file of type ET_EXEC, do you think this works? rather
> than converting core file to exe?

You might want to take a look at GDB's generate-core-file command.

-- 
Daniel Jacobowitz
CodeSourcery
