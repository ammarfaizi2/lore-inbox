Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291197AbSBLWBV>; Tue, 12 Feb 2002 17:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291210AbSBLWBK>; Tue, 12 Feb 2002 17:01:10 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:46603 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291197AbSBLWA4>;
	Tue, 12 Feb 2002 17:00:56 -0500
Date: Tue, 12 Feb 2002 20:00:41 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: File BlockSize
In-Reply-To: <20020212205722.GH767@holomorphy.com>
Message-ID: <Pine.LNX.4.33L.0202121959260.12554-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2002, William Lee Irwin III wrote:
> On Tue, Feb 12, 2002 at 02:37:43PM +0000, Alan Cox wrote:
> > Going to a block size bigger than page size causes all sorts of fun with
> > allocation failures if there are not two pages free adjacent to one another
> > when allocating, and isn't really worth the cost.
>
> This sounds like fairly severe memory fragmentation, which seems more
> worrisome to me than blocksize constraints. Should I look into that?

Sorry for being dense, but I don't see why an 8 kB block would
need to occupy 2 contiguous pages in ram.

The page cache is indexed in pages, it should be easy enough to
do the disk IO on the 8 kB on-disk block as 2 4 kB IOs, each to
a different page in RAM.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

