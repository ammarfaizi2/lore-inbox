Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289776AbSAWKcN>; Wed, 23 Jan 2002 05:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289772AbSAWKby>; Wed, 23 Jan 2002 05:31:54 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:46861 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289775AbSAWKbq>;
	Wed, 23 Jan 2002 05:31:46 -0500
Date: Wed, 23 Jan 2002 08:31:32 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <vda@port.imtp.ilyichevsk.odessa.ua>, <linux-kernel@vger.kernel.org>,
        <andrea@suse.de>, <alan@redhat.com>, <akpm@zip.com.au>,
        <vherva@niksula.hut.fi>
Subject: Re: Athlon/AGP issue update
In-Reply-To: <20020123.022441.21593293.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L.0201230829430.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, David S. Miller wrote:

> But the only thing I am still confused about, is what 4MB mappings
> have to do with any of this.  What I take from the description is that
> the problem will still exist after 4MB mappings are disabled.  What
> prevents the processor from doing the speculative store to the
> cacheable mappings once 4MB pages are disabled?
>
> At best, I bet turning off 4MB pages makes the bug less likely.
> It does not eliminate the chance to hit the bug.

I've asked the same question yesterday on the phone.

The explanation is pretty simple:

1) the video driver gets free pages for the agp
   data structures

2) the speculative store doesn't cross page
   boundaries

This means that when using 4kB pages instead of 4MB
pages the agp data is "fenced off" from the other
kernel data.

kind regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

