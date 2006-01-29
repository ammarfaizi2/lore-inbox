Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWA2Le3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWA2Le3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 06:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWA2Le3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 06:34:29 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:61896 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1750933AbWA2Le2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 06:34:28 -0500
Date: Sun, 29 Jan 2006 12:33:20 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Adrian Bunk <bunk@stusta.de>, Christoph Hellwig <hch@infradead.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths library
Message-ID: <20060129113320.GA21386@hardeman.nu>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Adrian Bunk <bunk@stusta.de>, Christoph Hellwig <hch@infradead.org>,
	keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
References: <20060127092817.GB24362@infradead.org> <1138312694656@2gen.com> <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com> <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de> <20060128104611.GA4348@hardeman.nu> <1138466271.8770.77.camel@lade.trondhjem.org> <20060128165732.GA8633@hardeman.nu> <1138504829.8770.125.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
In-Reply-To: <1138504829.8770.125.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.11
Content-Transfer-Encoding: 8BIT
X-SA-Score: -2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 10:20:29PM -0500, Trond Myklebust wrote:
>On Sat, 2006-01-28 at 17:57 +0100, David Härdeman wrote:
>> What about the first paragraph of what I wrote? You are going to want to 
>> keep often-used keys around somehow, proxy certificates is not a 
>> solution for your own use of your personal keys and with the exception 
>> of hardware solutions such as smart cards, the keys will be safer in the 
>> kernel than in a user-space daemon...
>
>I don't get this explanation at all.
>
>Why would you want to use proxy certificates for you own use? Use your
>own certificate for your own processes, and issue one or more proxy
>certificates to any daemon that you want to authorise to do some limited
>task.

I meant that you can't use proxy certs for your own use, so you still need 
to store your own cert/key somehow...and I still believe that the kernel 
keyring is the best place...

>...and what does this statement about "keys being safer in the kernel"
>mean?

swap-out to disk, ptrace, coredump all become non-issues. And in 
combination with some other security features (such as disallowing 
modules, read/write of /dev/mem + /dev/kmem, limited permissions via
SELinux, etc), it becomes pretty hard for the attacker to get your 
private key even if he/she manages to get access to the root account.

>> Further, the mpi and dsa code can also be used for supporting signed 
>> modules and binaries...the "store dsa-keys in kernel" part adds 376 
>> lines of code (counted with wc so comments and includes etc are also 
>> counted)...
>
>Signed modules sounds like a better motivation, but is a full dsa
>implementation in the kernel really necessary to achieve this?

How would you do it otherwise?

Re,
David
