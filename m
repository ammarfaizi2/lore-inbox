Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbSA0BPL>; Sat, 26 Jan 2002 20:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287436AbSA0BPB>; Sat, 26 Jan 2002 20:15:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51716 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284180AbSA0BOu>; Sat, 26 Jan 2002 20:14:50 -0500
Message-ID: <3C535471.9010605@zytor.com>
Date: Sat, 26 Jan 2002 17:14:25 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Really odd behavior of overlapping named pipes?
In-Reply-To: <20020126021610.YKAU20810.femail29.sdc1.sfba.home.com@there> <a2trjq$h2r$1@cesium.transmeta.com> <20020127010724.GB8125@tapu.f00f.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:

> On Sat, Jan 26, 2002 at 01:07:06AM -0800, H. Peter Anvin wrote:
> 
>     It sounds like what you're expecting is what would happen if we
>     allowed open() on a Unix domain socket to do the obvious thing (can
>     we, pretty please?)
> 
> Why?  Do any other OS's support this?  It seems pointless if it's
> nonportable, but, if for arguments sake, several other OSs provide
> this then I guess we could for compatability reasons... and I assume
> with this proposal open would be jost socket/connect --- accept
> behavior would still require accept?
> 


Yes, that I would.  Why is it so "pointless if it's nonportable?"  Under 
that argument Linux should never be able to do anything that any other 
OS hasn't already done.  What it does it it makes it very easy to 
replace a file-based convention -- say, purely as an example, 
~/.signature -- with a process-based one.  A FIFO won't do, since it 
only contains one data stream and therefore can become corrupt if opened 
by more than one process.

There should be no reason to limit the utility of common operations. 
open() is one of the fundamental operations -- you can open *anything* 
in the namespace, except, for no good reason, Unix domain sockets.

	-hpa


