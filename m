Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287516AbSBGMRD>; Thu, 7 Feb 2002 07:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287532AbSBGMQx>; Thu, 7 Feb 2002 07:16:53 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:30219 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287516AbSBGMQq>;
	Thu, 7 Feb 2002 07:16:46 -0500
Date: Thu, 7 Feb 2002 10:16:22 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <alan@lxorguk.ukuu.org.uk>, <Ulrich.Weigand@de.ibm.com>,
        <zaitcev@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: The IBM order relaxation patch
In-Reply-To: <20020206.200100.85392985.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L.0202071015470.17850-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2002, David S. Miller wrote:

> I do not think the Linus VM behavior is unreasonable, which basically
> amounts to continually trying to free pages for all order 3 and below
> allocations (if you can sleep and you aren't PF_MEMALLOC etc.).

The only problem is that it doesn't.  It won't try to free
pages once you have enough free pages, which means you'll
just end up in a livelock.

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

