Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289982AbSAWTNQ>; Wed, 23 Jan 2002 14:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289979AbSAWTNE>; Wed, 23 Jan 2002 14:13:04 -0500
Received: from ns.suse.de ([213.95.15.193]:275 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289982AbSAWTMu>;
	Wed, 23 Jan 2002 14:12:50 -0500
Date: Wed, 23 Jan 2002 20:12:48 +0100
From: Andi Kleen <ak@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Badari Pulavarty <badari@us.ibm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH *] rmap VM, version 12
Message-ID: <20020123201248.A27249@wotan.suse.de>
In-Reply-To: <OFB07135FF.E6C5BE7E-ON88256B4A.0068CB3F@boulder.ibm.com> <Pine.LNX.4.33L.0201231704430.32617-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0201231704430.32617-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 05:05:13PM -0200, Rik van Riel wrote:
> > uncompressing linux ...
> > booting ..
> 
> At this point we're not even near using pagetables yet,
> so I guess this is something else ...
> 
> (I'm not 100% sure, though)

It happens when you crash before console initialization.  VM is already
low level initialized there, but other CPUs should not have been booted yet.

Usual way to debug is to link with one of the patches that replace printk
with an "early_printk" that writes directly into the vga text buffer and
works without the console subsystem. 

-andi
