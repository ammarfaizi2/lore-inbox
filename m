Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbTBSW6Y>; Wed, 19 Feb 2003 17:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbTBSW6Y>; Wed, 19 Feb 2003 17:58:24 -0500
Received: from 5-077.ctame701-1.telepar.net.br ([200.193.163.77]:52192 "EHLO
	5-077.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262394AbTBSW6X>; Wed, 19 Feb 2003 17:58:23 -0500
Date: Wed, 19 Feb 2003 20:08:01 -0300 (BRT)
From: Rik van Riel <riel@imladris.surriel.com>
To: Dejan Muhamedagic <dejan@hello-penguin.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: vm issues on sap app server
In-Reply-To: <20030219171432.A6059@smp.colors.kwc>
Message-ID: <Pine.LNX.4.50L.0302192004410.2329-100000@imladris.surriel.com>
References: <20030219171432.A6059@smp.colors.kwc>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2003, Dejan Muhamedagic wrote:

> Both servers swap constantly, but the 2.4.20aa1 at a 10-fold
> higher rate.  OTOH, there should be enough memory for
> everything.  It seems like both VMs have preference for
> cache.  Is it possible to reduce the amount of memory used
> for cache?

Yes, you can reduce the size of the cache above which the
pageout code will only reclaim cache and not application
data.  To set the percentage to 10% (from the default 5%):

echo 1 10 > /proc/sys/vm/pagecache

> Finally, there's a third SAP app server, an RS6000 running
> AIX with the same amount of memory, which seems to be more
> stable under various loads.

In that case you're probably familiar with the cache size
tuning, since AIX has the exact same tuning knob as rmap ;)

kind regards,

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/
