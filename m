Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289653AbSBEWDO>; Tue, 5 Feb 2002 17:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289824AbSBEWDF>; Tue, 5 Feb 2002 17:03:05 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:45245 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S289653AbSBEWCw>;
	Tue, 5 Feb 2002 17:02:52 -0500
Date: Tue, 05 Feb 2002 22:02:45 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: How to check the kernel compile options ?
Message-ID: <2006875340.1012946564@[195.224.237.69]>
In-Reply-To: <a3mjhc$qba$1@cesium.transmeta.com>
In-Reply-To: <a3mjhc$qba$1@cesium.transmeta.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, 04 February, 2002 10:22 AM -0800 "H. Peter Anvin" 
<hpa@zytor.com> wrote:

> I have had in my /sbin/installkernel a clause to save .config as
> config-<foo> when I install vmlinuz-<foo>; I believe anyone not doing
> that[1] is, quite frankly, a moron.

Always being willing to rise to the challenge of being called
a moron:

Seems to me that if the prefered method of booting becomes
an initrd-esque thing + pivot_root, I /may/ (reasonably)
perhaps have these files on the initrd anyway, and /might/
not have it mounted (or at least not mounted on the same
path across multiple distributions), in which case being
able to access them through /proc (which incidentally
could do the decompression for us, giving plain text
out of /proc and using minimal memory) might be useful.
[of course this /is/ saving config-foo, but to a place
where it's might be useful to access it from /proc]

Ditto ksyms etc.

An advantage of having the kernel, config, ksyms
etc. as one atomic lump is one of the same reasons
as people are looking to have kernel and modules as one
atomic lump - i.e. much less chance of the wrong
ones being looked at.

I would be surprised if there is anyone on this list
who has not lost at some point either the .config, the
kysms, or something similar associated with at least
one build they've made.

--
Alex Bligh
