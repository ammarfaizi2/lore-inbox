Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbUFBNC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUFBNC3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 09:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbUFBNC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 09:02:29 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:11784 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S262476AbUFBNCZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 09:02:25 -0400
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Sean Estabrooks <seanlkml@sympatico.ca>, szepe@pinerecords.com,
       linux-kernel@vger.kernel.org, matt_domsch@dell.com
Subject: Re: 2.6.x partition breakage and dual booting
References: <40BA2213.1090209@pobox.com>
	<20040530183609.GB5927@pclin040.win.tue.nl>
	<40BA2E5E.6090603@pobox.com> <20040530200300.GA4681@apps.cwi.nl>
	<s5g8yf9ljb3.fsf@patl=users.sf.net>
	<20040531180821.GC5257@louise.pinerecords.com>
	<s5gaczonzej.fsf@patl=users.sf.net>
	<20040531170347.425c2584.seanlkml@sympatico.ca>
	<s5gfz9f2vok.fsf@patl=users.sf.net>
	<20040601235505.GA23408@apps.cwi.nl>
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gpt8ijf1g.fsf@patl=users.sf.net>
Date: 02 Jun 2004 09:02:23 -0400
In-Reply-To: <20040601235505.GA23408@apps.cwi.nl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <Andries.Brouwer@cwi.nl> writes:

> We have "sectors" and it gives a count of sectors, like 0x7280b80
> (yecch - why in hex??).
> But "legacy_sectors" is not a number of sectors, but a number of
> sectors per track, just like "default_sectors_per_track".
> 
> We have "default_heads" and it is a number of heads, like 0xff
> (yecch - why in hex??).
> But "legacy_heads" is not a number of heads, it is the largest
> head number, that is, one less than the number of heads.
> 
> Please, now that this is still unused, fix your names and/or
> your code. Names could be legacy_max_head (etc.) if you want
> to keep the values, or otherwise add 1 to the values.

Well, the EDD module belongs to Matt Domsch.  I only contributed the
"legacy_*" code and names.

If it is OK with Matt, I agree we should rename legacy_heads to
legacy_max_head and legacy_sectors to legacy_sectors_per_track.  I
doubt anybody other than myself is using these yet anyway.

> Also - people will try to match the 0x7280b80 for int13_dev83 with
> the 120064896 sectors that dmesg or hdparm -g reports for /dev/hdf.
> Life would be easier with values given in decimal, as they are
> everywhere else.

I used hex for legacy_* because that is what all the other fields
already used.  It was not my decision, and I have no opinion either
way.  Convince Matt.

 - Pat
