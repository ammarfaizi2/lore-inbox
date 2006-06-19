Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWFSOT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWFSOT0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 10:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWFSOT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 10:19:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:17962 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932395AbWFSOTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 10:19:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=FJ7VXTVVREG7WO5aTFbvACvkNEMIlrf4nfB6wwr3sSp2ApljOtSqwLGJ0H8VskPewGvMFXvMo1gcXHAMPScf+rlwz1vF87qJonp0aljLYmmzKka9j603rHPu4w7hnr5CWhTBEodvZWOPXRYE9odSUCYIiPEmUWpAm6oHfYiITVw=
Message-ID: <4496B261.9050005@gmail.com>
Date: Mon, 19 Jun 2006 16:19:13 +0200
From: Wojciech Moczulski <wmoczulski@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Bernard Blackham <bernard@blackham.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Suspending and resuming a single task
References: <4495F344.8080705@gmail.com>	 <E1Fs7vj-0003Rm-00@chiark.greenend.org.uk>  <4495F8B1.7020304@gmail.com> <1150690028.2207.8.camel@localhost>
In-Reply-To: <1150690028.2207.8.camel@localhost>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernard Blackham napisa³(a):
> On Mon, 2006-06-19 at 03:06 +0200, Wojciech Moczulski wrote:
> 
>>Matthew Garrett napisa³(a):
>>
>>>http://cryopid.berlios.de/ ?
>>
>>OK, and if I want to parse the path to a file, where process state is saved,
>>to the kernel and let the kernel module restart the process? Is it possible to
>>do it this way (without building self-executable binary)?
> 
> 
> One of the earlier incarnations of CryoPID did more or less this - it
> generated an ELF file with segments as laid out in the original image,
> so that the kernel ELF loaded did all the dirty work. It still required
> an extra portion of code to be injected into the binary in order to
> restore registers, file descriptors, etc. I recall the main reason I
> switched away from it was to be able to compress the images.
> 
> If you're going to be modifying the kernel in order to resume processes,
> then implementing it as an binary format handler (fs/binfmt_*) may be
> what you're looking for.

I must say I didn't thought of it in this way. First version of my concept
assumned storing task state, restoring it later and get it running by creating
a new process by hand and rewriting necessary data.

Well, thank anyway.

Regards,
Wojciech
