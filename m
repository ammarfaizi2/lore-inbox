Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289159AbSA1IWV>; Mon, 28 Jan 2002 03:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289161AbSA1IWM>; Mon, 28 Jan 2002 03:22:12 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:9991 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289159AbSA1IV6>;
	Mon, 28 Jan 2002 03:21:58 -0500
Date: Mon, 28 Jan 2002 06:21:40 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Rik van Riel's vm-rmap
In-Reply-To: <1012193811.24890.4.camel@tiger>
Message-ID: <Pine.LNX.4.33L.0201280613510.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Jan 2002, Louis Garcia wrote:

> Does he still use classzones as the basis for the vm? I thought that
> linux was trying to get away from classzones for better NUMA support in
> 2.5??

Nope.  I've done a few modifications:

1) the IMHO inflexible classzone stuff has been removed

2) we have reverse mappings, so we can do our pageout
   scan by physical address

3) this in turn means the active, inactive_dirty and
   inactive_clean lists are per zone ... allowing us
   to scan only in those zones where we actually need
   to free pages

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

