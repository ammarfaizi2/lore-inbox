Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbUCOTIz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 14:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbUCOTIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 14:08:53 -0500
Received: from alesia-4-82-66-59-64.fbx.proxad.net ([82.66.59.64]:9633 "HELO
	rooter.tripnotik.fr") by vger.kernel.org with SMTP id S262666AbUCOTIp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 14:08:45 -0500
X-Qmail-Scanner-Mail-From: jdidron@tripnotik.dyndns.org via rooter
X-Qmail-Scanner: 1.20 (Clear:RC:1(192.168.0.249):. Processed in 0.038041 secs)
Message-ID: <40560C0E.7060500@tripnotik.dyndns.org>
Date: Mon, 15 Mar 2004 21:03:26 +0100
From: Julien Didron <jdidron@tripnotik.dyndns.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040313
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH try3] a better Silicon Image SATA mod15 write fix?
References: <4055D032.1090708@pobox.com> <4055EF4F.8060803@pobox.com> <4055F045.40102@pobox.com>
In-Reply-To: <4055F045.40102@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

    This driver works :o)
    running hdparm gives those results :
    Timing buffered disk reads:  170 MB in  3.00 seconds =  56.60 MB/sec 
(with 2.6.4-bk4 and sata_sil.c try 3)
    Timing buffered disk reads:  170 MB in  3.01 seconds =  56.56 MB/sec 
(with 2.6.4-mm2)

    running boonie on the 2.6.4-mm2 version hangs the computer, with no 
possibilities of doing anything (can't even use the magic SysRq keys), 
while on the 2.6.4-bk4 version using the patched version of sata_sil.c 
it doesn't exactly hang : it is still possible to switch from one 
console to another, but it's impossible to log into any of them (after 
typing in the password, you never get the prompt).
    here is the command I used :
    bonnie++ -u jdidron -d /tmp -x 10 -s 2g -n 32:30000:5:500 -m 
kisskool > output

Mobo : A7N8X Deluxe
HD : 6Y120L0

Jeff Garzik wrote:

> Sigh... it would help to disable the old errata fix.
>
> Try 3.
>

