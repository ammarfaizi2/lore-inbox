Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266457AbUITMOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266457AbUITMOV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 08:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266391AbUITMOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 08:14:21 -0400
Received: from cantor.suse.de ([195.135.220.2]:1510 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266459AbUITMOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 08:14:12 -0400
To: Paulo Marques <pmarques@grupopie.com>
Cc: Olaf Hering <olh@suse.de>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl>
	<20040920094602.GA24466@suse.de> <jeoek1xn9p.fsf@sykes.suse.de>
	<20040920105409.GH5482@DervishD> <jek6upxj1a.fsf@sykes.suse.de>
	<414EC43B.8040507@grupopie.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: YOW!!
Date: Mon, 20 Sep 2004 14:14:09 +0200
In-Reply-To: <414EC43B.8040507@grupopie.com> (Paulo Marques's message of
 "Mon, 20 Sep 2004 12:51:23 +0100")
Message-ID: <jeekkxxhm6.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques <pmarques@grupopie.com> writes:

> Andreas Schwab wrote:
>> DervishD <lkml@dervishd.net> writes:
>> 
>>>    Hi Andreas :)
>>>
>>> * Andreas Schwab <schwab@suse.de> dixit:
>>>
>>>>>- fix all broken apps that still rely on mtab. like GNU df(1)
>>>>
>>>>df does not rely on /etc/mtab.  It relies on getmntent.
>>>
>>>    Then my GNU df has any problem :???
>> No, if any then getmntent.
>
> I don't get this. From "man getmntent" it seems that getmntent is just a
> parser for /etc/mtab, and that you must call "setmntent" with the filename
> you want to parse.
>
> So if you do "setmntent("/etc/mtab",...)" you're explicitly saying that
> you want getmntent to use /etc/mtab. This is just a open/read in disguise.
>
> Am I missing something?

No.  You are of course right, but the df sources don't reference /etc/mtab
directly, but use _PATH_MOUNTED from <paths.h>.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
