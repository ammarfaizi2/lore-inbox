Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287919AbSAPVcJ>; Wed, 16 Jan 2002 16:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287918AbSAPVcA>; Wed, 16 Jan 2002 16:32:00 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:16143 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287881AbSAPVbw>;
	Wed, 16 Jan 2002 16:31:52 -0500
Date: Wed, 16 Jan 2002 19:31:42 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: christian e <cej@ti.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: aa works for me..rrmap didn't
In-Reply-To: <3C45ED3A.7060403@ti.com>
Message-ID: <Pine.LNX.4.33L.0201161923450.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, christian e wrote:

> I think that's about it ;-)
>
> And I did the echo 500 > /proc/sys/vm/vm_mapped_ratio with the aa patch..

Ahhhhh ok.

I think your workload (leaving a huge process inactive for
a few minutes, then switching desktops to that process)
really does need a special VM tuning knob.

I guess I'll add a knob like this to the -rmap VM.

I'll try to keep it a bit simpler than vm_max_mapped too,
it would seem it's possible to set vm_max_mapped so high
that the box will refuse swapping under any circumstance
and the box will just crash if you have too much RAM ;)))
(then again, root can always do this)

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

