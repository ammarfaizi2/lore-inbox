Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWITWBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWITWBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 18:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWITWBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 18:01:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:57615 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932239AbWITWBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 18:01:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=aRe752BPFBJQ6yYkENY6K805W3bpyRnh5tID+YQ4sYnsTePEd6sr/R9VGmlm0jAtiOno9czq1AJUKue8Xr59fboXMUdQdJOMQuFvYCTtlvSrzVDznVD3HpiN27wr8z+qpG66eyiICXSLchUrdF/V463U2CdAHgth5SvXKqEBQt0=
Message-ID: <4511BA29.8050903@gmail.com>
Date: Thu, 21 Sep 2006 00:01:13 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, support@moxa.com.tw
Subject: Re: [PATCH] mxser: make an experimental clone
References: <916688631212913221@karneval.cz> <20060920120245.37e2db9b.akpm@osdl.org>
In-Reply-To: <20060920120245.37e2db9b.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 20 Sep 2006 16:06:55 +0200 (CEST)
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> Andrew Morton wrote:
>>> Ho hum, this is hard.  I guess breaking the driver is one way to find out
>>> who is using it, but those who redistribute the kernel for a living might
>>> not appreciate the technique.
>>>
>>> Perhaps we could create an mxser-new.c and offer that in config, plan to
>>> remove mxser.c N months hence?
>> Ok, here's a patch doing this. When you apply it, drop
>> mxser-upgrade-to-191.patch, please, to get back unmodified version.
>>
> 
> It was, umm, naive to assume that was the only outstanding patch against
> mxser.c.  I had four patches.  One wasn't actually in use and one I just
> dropped, so we now have
> serial-fix-up-offenders-peering-at-baud-bits-directly.patch and
> const-struct-tty_operations.patch.

Aargh. Sorry for that, next time I'll make a revert- variant.

>> mxser: clone a new driver
>>
>> Clone a new driver for moxa smartio devices. It contains update to version
>> 1.9.1 from Moxa site and static to dynamic structures (including some
>> renaming) conversion for further work -- converting to pci probing.
> 
> That wasn't a good way to do this.  It would have been (much) better to
> have one patch which copies mxser.c to mxser_new.c and *nothing else*. 
> Then, new patches which update mxser_new.c.
> 
> So I have converted your patch into one which simply copies mxser.[ch] to
> mxser_new.[ch] and which makes no other changes.  The versions which were
> copied were those _after_ the two pending patches were applied.  Please
> send updates against those new files, thanks.

Ok, thank you,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
