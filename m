Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965359AbWJ2Tm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965359AbWJ2Tm6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 14:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965358AbWJ2Tm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 14:42:58 -0500
Received: from smtp-out.rrz.uni-koeln.de ([134.95.19.53]:8430 "EHLO
	smtp-out.rrz.uni-koeln.de") by vger.kernel.org with ESMTP
	id S965359AbWJ2Tm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 14:42:57 -0500
Message-ID: <45450422.4030706@rrz.uni-koeln.de>
Date: Sun, 29 Oct 2006 20:42:26 +0100
From: Berthold Cogel <cogel@rrz.uni-koeln.de>
User-Agent: IceDove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Samuel Ortiz <samuel@sortiz.org>
CC: linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net
Subject: Re: Oops in __wake_up_common with irda, linux-2.6.18
References: <45426EC0.3070004@rrz.uni-koeln.de> <20061029175024.GA5356@sortiz.org>
In-Reply-To: <20061029175024.GA5356@sortiz.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Ortiz schrieb:
> Hi Berthold,
> 
> On Fri, Oct 27, 2006 at 10:40:32PM +0200, Berthold Cogel wrote:
>> Hello!
>>
>> I got a kernel Oops in __wake_up_common while receiving a file on my
>> notebook via irda  from a Pocket PC with 'ircp -r' (sending files to the
>> PocketPC works).
> Could you try applying this patch:
> http://marc.theaimsgroup.com/?l=linux-netdev&m=115792756816966&w=2
> 
> It's supposed to fix this OOPS. Please let me know.
> 
> Cheers,
> Samuel.

Hello Samuel,

with 2.6.18 parts of the patch failed:

acer01:/usr/src/linux# patch -p1 < ../irda_patch.txt
patching file net/irda/af_irda.c
Hunk #1 FAILED at 132.
Hunk #2 FAILED at 1213.
Hunk #3 FAILED at 1223.
Hunk #4 succeeded at 1356 with fuzz 2.
Hunk #5 succeeded at 1409 with fuzz 2.
3 out of 5 hunks FAILED -- saving rejects to file net/irda/af_irda.c.rej

This happens with 2.6.18.1 too. I haven't tried 2.6.19-rc... yet.

I've attached af_irda.c.rej for 2.6.18.

Berthold
