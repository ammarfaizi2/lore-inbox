Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288691AbSAIBZq>; Tue, 8 Jan 2002 20:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288693AbSAIBZg>; Tue, 8 Jan 2002 20:25:36 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:39947 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288691AbSAIBZ2>;
	Tue, 8 Jan 2002 20:25:28 -0500
Date: Tue, 8 Jan 2002 23:25:12 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: i686 SMP systems with more then 12 GB ram with 2.4.x kernel,
 cache buffer bug ?
In-Reply-To: <Pine.LNX.4.33.0201081524360.14913-100000@shell1.aracnet.com>
Message-ID: <Pine.LNX.4.33L.0201082324180.2985-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, M. Edward (Ed) Borasky wrote:

> > It seems that the kernel does a good job of releasing dcache or icache,
> > but the buffer_heads are filling up the released mem.
>
> In terms of "control knobs", would a limit on page cache size imply a
> limit on "buffer_heads", or do we really need the control knob on
> "buffer_heads" and not on the page cache? Or would we need both?

We can just remove the buffer heads from the page cache
pages without any problem (except that on writeback we
have to look up where exactly the page should be written
to on disk).

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

