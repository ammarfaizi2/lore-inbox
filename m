Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbULBN5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbULBN5r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 08:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbULBN5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 08:57:47 -0500
Received: from news.suse.de ([195.135.220.2]:46006 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261624AbULBN5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 08:57:45 -0500
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: Arnd Bergmann <arnd@arndb.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cosa.h ioctl numbers
References: <20041202124456.GF11992@fi.muni.cz>
	<200412021358.00844.arnd@arndb.de> <20041202131224.GI11992@fi.muni.cz>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Okay..  I'm going home to write the ``I HATE RUBIK's CUBE
 HANDBOOK FOR DEAD CAT LOVERS''..
Date: Thu, 02 Dec 2004 14:57:43 +0100
In-Reply-To: <20041202131224.GI11992@fi.muni.cz> (Jan Kasprzak's message of
 "Thu, 2 Dec 2004 14:12:25 +0100")
Message-ID: <jeu0r4ajl4.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak <kas@fi.muni.cz> writes:

> Arnd Bergmann wrote:
> : >  /* Write the block to the device memory (i.e. download the microcode) */
> : > -#define COSAIODOWNLD	_IOW('C',0xf2, struct cosa_download)
> : > +#define COSAIODOWNLD	_IOW('C',0xf2, struct cosa_download *)
> : 
> : Isn't that rather misleading? I suppose the real argument is 
> : 'struct cosa_download', so you should have some kind of comment there, 
> : e.g.
> : 
> : #define COSAIODOWNLD _IOW('C',0xf2, long) /* actually struct cosa_download */
>
> 	Well, the third argument of ioctl(2) is of type
> struct cosa_download *.
>
> 	OK, second try with comments added.

If you want real compatibility you should use size_t, which is what 2.4 is
effectively using.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
