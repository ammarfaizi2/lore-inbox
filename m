Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264369AbTH1WCZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 18:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264348AbTH1WBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 18:01:23 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:7063 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264360AbTH1WBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 18:01:04 -0400
Subject: Re: [RFC] extents support for EXT3
From: =?ISO-8859-1?Q?Ram=F3n?= Rey =?UTF-8?Q?Vicente?=
	 =?UTF-8?Q?=F3=AE=A0=92?= <retes_simbad@yahoo.es>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
In-Reply-To: <m33cfm19ar.fsf@bzzz.home.net>
References: <m33cfm19ar.fsf@bzzz.home.net>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1062086590.2623.3.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 29 Aug 2003 00:00:45 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El jue, 28-08-2003 a las 10:22, Alex Tomas escribió:

> this is 2nd version of the patch. changes:
>   - error handling seems completed
>   - lots of cleanups and comments
>   - few minor bug fixed
> 
> this version of the patch tries to solve couple
> of corner cases:
>   - very long truncate
>   - rewrite 
> 
> it survived dbench, bonnie++ and fsx tests.

It seems very good job.

> take a look at numbers I've just got, please.
> 
>                       before      after
> 5GB file, creation:   2m31.197s   2m21.933s
> 5GB file, read:       2m25.439s   2m24.833s
> 5GB file, rewrite:    2m48.434s   2m20.958s
> 5GB file, removal:    0m8.760s    0m0.858s
> 
>              before           after
> dbench 16:   99.9868 MB/sec   179.243 MB/sec 16 procs
> dbench 16:   89.9919 MB/sec   203.119 MB/sec 16 procs
> dbench 16:   73.5519 MB/sec   185.815 MB/sec 16 procs
> dbench 16:   94.6312 MB/sec   188.519 MB/sec 16 procs
> 
> 
> to use extents you have to use 'extents' mount option

This patch could be included with ext3 in 2.6.x?
-- 
Ramón Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
------------------------------------------------------------
gpg public key ID 0xBEBD71D5 # http://pgp.escomposlinux.org/

