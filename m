Return-Path: <linux-kernel-owner+w=401wt.eu-S1030258AbXAKK5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbXAKK5A (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 05:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbXAKK5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 05:57:00 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:2941 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030258AbXAKK47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 05:56:59 -0500
Message-ID: <45A617E7.2060901@shadowen.org>
Date: Thu, 11 Jan 2007 10:56:39 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jean Delvare <khali@linux-fr.org>, Roman Zippel <zippel@linux-m68k.org>,
       Andrey Borzenkov <arvidjaar@mail.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Herbert Poetzl <herbert@13thfloor.at>,
       Olaf Hering <olaf@aepfle.de>
Subject: Re: .version keeps being updated
References: <20070109102057.c684cc78.khali@linux-fr.org> <20070109170550.AFEF460C343@tzec.mtu.ru> <20070109214421.281ff564.khali@linux-fr.org> <Pine.LNX.4.64.0701101426400.14458@scrub.home> <20070110181053.3b3632a8.khali@linux-fr.org> <Pine.LNX.4.64.0701101058200.3594@woody.osdl.org> <Pine.LNX.4.64.0701101131470.3594@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701101131470.3594@woody.osdl.org>
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 10 Jan 2007, Linus Torvalds wrote:
>> Which is why "__init" is wrong. It causes the linker to either put it at 
>> the end of the thing (which would break the SuSE tool). Alternatively it 
>> causes section mismatch problems ("init" and "const" don't work that well 
>> together), in which case it might work, but only due to toolchain bugs.
>>
>> Grr.
> 
> Does anybody have the silly SuSE kernel version tool, and could test that 
> without the "__init" it all actually works?

Ok, testing of this worked here across the board.    All using the same
configs we used for the last round of testing on this issue.  The main
problem machine ppc64 on SLES9 with CIFS enabled passes with this patch
plus __init removed.

Results on TKO.

Acked-by: Andy Whitcroft <apw@shadowen.org>

-apw

