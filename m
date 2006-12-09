Return-Path: <linux-kernel-owner+w=401wt.eu-S1759157AbWLITmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759157AbWLITmi (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 14:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759315AbWLITmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 14:42:38 -0500
Received: from mail.tmr.com ([64.65.253.246]:50442 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759157AbWLITmh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 14:42:37 -0500
Message-ID: <457B12A2.7090104@tmr.com>
Date: Sat, 09 Dec 2006 14:46:42 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Rakhesh Sasidharan <rakhesh@rakhesh.com>
CC: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: VCD not readable under 2.6.18
References: <20061209172332.2915.qmail@web57808.mail.re3.yahoo.com>
In-Reply-To: <20061209172332.2915.qmail@web57808.mail.re3.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-3; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rakhesh Sasidharan wrote:
> Infact, just inserting a CD is enough. No need for a media player to try and access the files. :)
> 
> The backend must be polling and trying to mount the disc upon insertion. Kernel 2.6.16 and before did that fine, but kernel 2.6.17 and above don't and give error messages. Which explains why downgrading the kernel solves the problem. (If it were a HAL or KDE/ GNOME problem then shouldn't downgrading the kernel *not* help?) Just thinking aloud ... 

I believe the problem is not that the kernel is providing an error, but 
that it is providing an error which is taken as "DIDN'T WORK THIS TIME, 
BUT TRY AGAIN" rather than a permanent error. Asking every 
media-consious application to be rewritten is perhaps not the best 
solution, either return another error, or return what application expect 
(non-error but no data??)

Changes which break a large number of applications are probably ill-advised.
> 
> ----- Original Message ----
> From: S.Ça»lar Onur <caglar@pardus.org.tr>
> To: Ismail Donmez <ismail@pardus.org.tr>
> Cc: Alan <alan@lxorguk.ukuu.org.uk>; Rakhesh Sasidharan <rakhesh@rakhesh.com>; rakheshster@yahoo.com; linux-kernel@vger.kernel.org
> Sent: Saturday, December 9, 2006 8:09:05 PM
> Subject: Re: VCD not readable under 2.6.18
> 
> 09 Ara 2006 Cts 16:15 tarihinde, Ismail Donmez ºunlar¹ yazm¹ºt¹: 
>> Well my bet is xine-lib is buggy somehow as I can reproduce this bug with
>> kaffeine ( KDE media player ).
> 
> Same symptoms occur with mplayer also, dmesg flooded with warnings, what about 
> hal or KDE's cdpolling backend?
> 
> Cheers


