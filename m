Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263936AbTDIXlr (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 19:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263884AbTDIXlr (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 19:41:47 -0400
Received: from brimstone.ucr.edu ([138.23.89.35]:53676 "EHLO
	mail-infomine.ucr.edu") by vger.kernel.org with ESMTP
	id S263936AbTDIXlq (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 19:41:46 -0400
Date: Wed, 9 Apr 2003 16:53:23 -0700
To: Ulrich Drepper <drepper@redhat.com>
Cc: fdavis@si.rr.com, linux-kernel@vger.kernel.org
Subject: Re: kernel support for non-english user messages
Message-ID: <20030409235323.GF1486@mail-infomine.ucr.edu>
References: <3E93A958.80107@si.rr.com> <20030409080803.GC29167@mea-ext.zmailer.org> <20030409080803.GC29167@mea-ext.zmailer.org> <20030409190700.H19288@almesberger.net> <3E94A1B4.6020602@si.rr.com> <3E94A4F8.8060304@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E94A4F8.8060304@redhat.com>
User-Agent: Mutt/1.3.28i
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
X-BeenThere: crackmonkey@crackmonkey.org
From: ruschein@mail-infomine.ucr.edu (Johannes Ruscheinski)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Ulrich Drepper:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Frank Davis wrote:
> 
> > "My suggestion would be to add the required i18n support to klogd, so
> > that kernel messages are translated as they are removed from dmesg into
> > syslog. Then, like any i18n support,
> 
> This is _not_ like any i18n support.  The problem is that normal
> translation support a la gettext or catgets() see the format strings and
> not the results.  Translating format strings is easy, translating
> results isn't since the translation part has to take the expansion of
> the format elements into account.
> 
> For numeric format elements this might be possible.  But not without
> major problems with %s.  Take hostnames or filenames, which could in
> theory contain spaces <U0020>.  You'd have to match using complex
> regular expressions.
> 
> Another problem is the explosion of messages.  Message lines are often
> composed from different sources.  If you see only the end result you'll
> have to account for all the different combinations.
> 
> 
> I don't say this is impossible, but it is a lot more work, a much more
> complex and slower translation mechanism, and (most critical) requires
> very strict rules for the creation of messages in the kernel.  I think
> the latter point is the killer.
> 
> - -- 
> - --------------.                        ,-.            444 Castro Street
> Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
> Red Hat         `--' drepper at redhat.com `---------------------------
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.1 (GNU/Linux)
> 
> iD8DBQE+lKT42ijCOnn/RHQRAlvSAJ9etqgCfTjZ6jZ2M6N+hRY0Hx97AgCeLERp
> nPqnFOWpR2s3PuUAuTYfN4E=
> =tTfW
> -----END PGP SIGNATURE-----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
How about augmenting printk to generate an escape for all numeric format
items.  If we translate into English we just strip out the escapes, otherwise
we use the escapes to translate the numbers appropriately.
-- 
Johannes
--
Dr. Johannes Ruscheinski
EMail:    ruschein_AT_infomine.ucr.edu ***          Linux                  ***
Location: science library, room G40    *** The Choice Of A GNU Generation! ***
Phone:    (909) 787-2279

"SYN -- ACK -- SYN, the mating call of the Internet."
                                         -- Anonymous
