Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283016AbRL0XZ1>; Thu, 27 Dec 2001 18:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283012AbRL0XZR>; Thu, 27 Dec 2001 18:25:17 -0500
Received: from pcow029o.blueyonder.co.uk ([195.188.53.123]:48389 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S283048AbRL0XZH>;
	Thu, 27 Dec 2001 18:25:07 -0500
Message-ID: <T581707b200ac1785e72b2@pcow029o.blueyonder.co.uk>
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <james@sutherland.net>
To: Dave Jones <davej@suse.de>,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
Date: Thu, 27 Dec 2001 23:25:36 +0000
X-Mailer: KMail [version 1.3.1]
Cc: Steven Walter <srwalter@yahoo.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112272332540.15706-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.33.0112272332540.15706-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 December 2001 10:44 pm, Dave Jones wrote:
> On Thu, 27 Dec 2001, Arnaldo Carvalho de Melo wrote:
> > > Patch is against kernel 2.4.17, should apply to 2.5 as well.
> >
> > Good job! But please consider splitting the patch per driver and sending
> > it to the respective maintainers.
>
> Someone with far too much time on their hands would be my personal
> hero[*] if they were to write a script (in language of their choice) to
> parse a diff, extract filename, and do lookup in a flat text file
> to find a list of maintainers/interested parties.

Sounds like a good idea; I'll give it a shot over the next few days, unless 
someone already has one :)

> Imagine a patch against devfs..
>
> $ cclist my.devfs.patch.diff
> Richard Gooch <rgooch@atnf.csiro.au>
> Alexander Viro <viro@math.psu.edu>

I'd add one level of abstraction: have each filename map to a "module" name. 
In this case, each filename relating to devfs would map to module "devfs"; 
there would then be an entry mapping devfs <-> Richard.

(Perhaps a hierarchy - fs.devfs - with people like Al listed for "fs"?)

> This 'little black book of addresses' doesn't have to be anything
> wonderful, but its tedious work for someone to make the textfile
> mapping the various source files to email addresses.

It should be a little easier having a mapping to a module - in most cases, 
there's a clear "module" to which each file belongs. Then just track who's 
"subscribed to" that module...


James.
