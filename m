Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289062AbSAIWgL>; Wed, 9 Jan 2002 17:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289057AbSAIWgF>; Wed, 9 Jan 2002 17:36:05 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:27401 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289056AbSAIWee>;
	Wed, 9 Jan 2002 17:34:34 -0500
Date: Wed, 9 Jan 2002 20:33:12 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: bounce buffer usage
In-Reply-To: <Pine.LNX.4.33L2.0201090844550.9139-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33L.0201092032210.2985-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Randy.Dunlap wrote:

> | +                       bounced_write++;
> | +               } else
> | +                       bounced_read++;
> |         }
>
> Is this the only place that kstat (kernel_stat) counters
> are not SMP safe...?

No, but we don't particularly care about that.  If you care
about making the statistics SMP safe, you probably also want
to make them CPU local so the cacheline isn't bounced around
all the time ;)

cheers,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

