Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbUBNOXZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 09:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbUBNOXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 09:23:25 -0500
Received: from mx.laposte.net ([81.255.54.11]:17095 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S261965AbUBNOWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 09:22:54 -0500
Message-ID: <402E3066.1020802@laPoste.net>
Date: Sat, 14 Feb 2004 15:27:50 +0100
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Organization: Adresse personnelle
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: fr-fr, fr, en-gb, en-us, en, ru
MIME-Version: 1.0
To: chris.siebenmann@utoronto.ca
CC: linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca>
In-Reply-To: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Siebenmann wrote:

> You write:
> | So what ?
> | Do you think an app that expects utf-8 filenames won't crash today when
> | served a byte sequence that's invalid UTF-8 ? (or an app that expects
> | ascii when served utf-8 oddities)
> 
>  Such apps are buggy and need to be fixed. 

Well, this means every single java app right now at least.

> This is not Unix's problem,

The w2k problem was at the app level mostly.
It would not have been OS responsibility to fix it.
*However* since the unix time conventions were a bit more sane than 
other os, the damage was less.

> any more than it is Unix's problem if an application frees memory twice,
> writes over unallocated memory, or destroys its stack.

The core os responsability is to share sanely ressources between apps.
Filenames are a shared ressource.
When encodings starts to be incompatible, resulting in applications 
crashes it's the OS job to define and enforce sane conventions so apps 
can coexist together.

Past oversights should not mean the problem should not be fixed 
(especially if solutions exist, even if they are not totally painless).

There is no more justification to keep encoding undefined as there is to 
keep time zone undefined. Last I've seen we're all pretty happy system 
time actually means something on unix (unlike other systems where it can 
be anything depending on the location where the initial installation was 
performed).

>  If all you care about is the future, you need no kernel support.
> Declare that all filesystem names are written in UTF-8, and make your
> tools deal with it. (Most will not care. A few will have to be fixed a
> bit.)

Tools won't change unless they're forced to. That's a plain fact.
As you wrote there shouldn't be a lot of fixups to do, since apps that 
can't deal with utf-8 now use ascii-only filenames anyway, but the few 
fixups that are needed won't happen without a little OS prodding.

(and without OS enforcement illegal utf-8 filename injection will remain 
a security risk)

And I write utf8 here, but any unicode form is fine with me as long as 
it's clearly defined and enforced by the FSs.

Cheers,

-- 
Nicolas Mailhot


