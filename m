Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSGYNJM>; Thu, 25 Jul 2002 09:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSGYNJL>; Thu, 25 Jul 2002 09:09:11 -0400
Received: from mta01bw.bigpond.com ([139.134.6.78]:15321 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S313305AbSGYNJJ>; Thu, 25 Jul 2002 09:09:09 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Header files and the kernel ABI
Date: Thu, 25 Jul 2002 23:08:00 +1000
User-Agent: KMail/1.4.5
References: <aho5ql$9ja$1@cesium.transmeta.com>
In-Reply-To: <aho5ql$9ja$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207252308.00656.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2002 16:28, H. Peter Anvin wrote:
> It seems to me that a reasonable solution for how to do this is not
> for user space to use kernel headers, but for user space and the
> kernel to share a set of common ABI description files[1].  These files
> should be highly stylized, and only describe things visible to user
> space.  Furthermore, if they introduce types, they should use the
> already-established __kernel_ namespace, and of course __s* and __u*
> could be used for specific types.
I like it (having just argued for it), except for the __s* and __u*.
The ABI definitions aren't for kernel programmers. They are for 
userspace programmers. So we should use standard types,
even if they are a bit ugly (and uint16_t isn't really much uglier
than __u16, and at least it doesn't carry connotations of
something that is meant to be internal, which is what the standard
double-underscore convention means). 

Please, let us agree that the ABI definition should use standard
types wherever possible.

Brad

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
