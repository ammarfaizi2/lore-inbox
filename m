Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWA2VNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWA2VNy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 16:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWA2VNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 16:13:54 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:190 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1751130AbWA2VNx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 16:13:53 -0500
Date: Sun, 29 Jan 2006 22:13:10 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Adrian Bunk <bunk@stusta.de>, Christoph Hellwig <hch@infradead.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths library
Message-ID: <20060129211310.GA20118@hardeman.nu>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Adrian Bunk <bunk@stusta.de>, Christoph Hellwig <hch@infradead.org>,
	keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
References: <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com> <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de> <20060128104611.GA4348@hardeman.nu> <1138466271.8770.77.camel@lade.trondhjem.org> <20060128165732.GA8633@hardeman.nu> <1138504829.8770.125.camel@lade.trondhjem.org> <20060129113320.GA21386@hardeman.nu> <1138552702.8711.12.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
In-Reply-To: <1138552702.8711.12.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.11
Content-Transfer-Encoding: 8BIT
X-SA-Score: -2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 11:38:22AM -0500, Trond Myklebust wrote:
>On Sun, 2006-01-29 at 12:33 +0100, David Härdeman wrote:
>>>Why would you want to use proxy certificates for you own use? Use your
>>>own certificate for your own processes, and issue one or more proxy
>>>certificates to any daemon that you want to authorise to do some limited
>>>task.
>> 
>>I meant that you can't use proxy certs for your own use, so you still need 
>>to store your own cert/key somehow...and I still believe that the kernel 
>>keyring is the best place...
>
>Agreed. Now, reread what I said above, and tell me why this is an
>argument for doing dsa in the kernel?

If you agree that the kernel keyring is the best place, it shouldn't be 
a big step to also agree that in-kernel signing is "good" since it 
allows you to use the key while it makes it possible for the kernel to 
refuse to divulge the private part...even to the user who added the key 
(i.e. yourself)...

>>>...and what does this statement about "keys being safer in the kernel"
>>>mean?
>> 
>> swap-out to disk, ptrace, coredump all become non-issues. And in 
>> combination with some other security features (such as disallowing 
>> modules, read/write of /dev/mem + /dev/kmem, limited permissions via
>> SELinux, etc), it becomes pretty hard for the attacker to get your 
>> private key even if he/she manages to get access to the root account.
>
>Turning off coredump is trivial. All the features that LSM provide apply
>to userland too (including security_ptrace()), so the SELinux policies
>are not an argument for putting stuff in the kernel.
>
>Only the swap-out to disk is an issue, and that is less of a worry if
>you use a time-limited proxy in the daemon.

How do you use a "time-limited proxy in the daemon" for your own 
keys/cerificates (e.g. ssh keys)?

Re,
David

