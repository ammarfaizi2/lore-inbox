Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbUK0Ecy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbUK0Ecy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbUK0E3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 23:29:20 -0500
Received: from neopsis.com ([213.239.204.14]:10135 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S262193AbUK0E2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 23:28:38 -0500
Message-ID: <41A802DC.2040604@dbservice.com>
Date: Sat, 27 Nov 2004 05:30:20 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tonnerre <tonnerre@thundrix.ch>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org,
       matthew@wil.cx, dwmw2@infradead.org, aoliva@redhat.com,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com> <20041127042942.GA10774@pauli.thundrix.ch>
In-Reply-To: <20041127042942.GA10774@pauli.thundrix.ch>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tonnerre wrote:
> Salut,
> 
> On Thu, Nov 25, 2004 at 03:13:12PM +0000, David Howells wrote:
> 
>>We've been discussing splitting the kernel headers into userspace API headers
>>and kernel internal headers and deprecating the __KERNEL__ macro. This will
>>permit a cleaner interface between the kernel and userspace; and one that's
>>easier to keep up to date.
> 
> 
> Fnord alert: you're trying to change the API and the ABI of Linux. The thing
> you fail to see is that Linux is not the only operating system in the world. 
> Big companies are very prone of using their compatibility code to make their
> program run in any odd way they like without actually having to change
> anything. Also, you're talking about assumptions that have been true for
> decades.
> 
> Big companies are already eyeing Linux with fear because our kernels don't
> actually work and because we break a lot of compatibility in the stable
> series. If you now come up with something that breaks basically everything
> so they need a new libc and everything, it's rather likely that they'll run
> away.
> 

I didn't say to change this now, not tomorrow...
Just tell them to change their code because, somewhere in the future,
the API might change. Maybe the new kernel APIs are better, faster, more
secure, so perhaps there is a good reason as why it would be better to
use the new API.
And for those who want to use the old API, let's give them the ability,
but also make it possible to compile the kernel with _only_ the new API.
The different distributions will take care of it.

And about the compatibility layer.. the companies have to make a
different one for each stable series anyways.


tom
