Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbTAJQzr>; Fri, 10 Jan 2003 11:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbTAJQzq>; Fri, 10 Jan 2003 11:55:46 -0500
Received: from [81.2.122.30] ([81.2.122.30]:39686 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265368AbTAJQzp>;
	Fri, 10 Jan 2003 11:55:45 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301101702.h0AH2iqI013527@darkstar.example.net>
Subject: Re: Problem in IDE Disks cache handling in kernel 2.4.XX
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 10 Jan 2003 17:02:44 +0000 (GMT)
Cc: fverscheure@wanadoo.fr, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br, andre@linux-ide.org
In-Reply-To: <1042219407.31848.71.camel@irongate.swansea.linux.org.uk> from "Alan Cox" at Jan 10, 2003 05:23:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > And by the way how are powered off the IDE drives ?
> > Because a FLUSH CACHE or STANDY or SLEEP is MANDATORY before
> > powering off the drive with cache enabled or you will enjoy lost
> > data.
> 
> We always issue standby or sleep commands to a drive before powering
> off which means the cache flush thing should never have been an
> issue.

I experienced drives spinning back up after they had been flushed on
powerdown, which is not necessarily wrong, (I.E. I never noticed any
data loss), but it's not ideal.  Can't we do:

* Standby
* Flush
* Standby

or is there a reason not to?  I know there were discussions about the
right order to do the standyby and flush, and as far as I remember, we
never reached a conclusion :-).

John.
