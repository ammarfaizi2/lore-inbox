Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310435AbSCXSgL>; Sun, 24 Mar 2002 13:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310825AbSCXSfz>; Sun, 24 Mar 2002 13:35:55 -0500
Received: from mout1.freenet.de ([194.97.50.132]:17642 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S310435AbSCXSfi> convert rfc822-to-8bit;
	Sun, 24 Mar 2002 13:35:38 -0500
Message-ID: <3C9E1CE0.3000609@freenet.de>
Date: Sun, 24 Mar 2002 19:37:20 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020323
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
CC: Rik van Riel <riel@conectiva.com.br>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
In-Reply-To: <Pine.LNX.4.44L.0203241444560.18660-100000@imladris.surriel.com> <200203241757.SAA20700@piggy.rz.tu-ilmenau.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by susi.maya.org id g2OIbLUg011029
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Bornträger wrote:
> Rik van Riel wrote:
> 
>>On Sun, 24 Mar 2002, Roy Sigurd Karlsbakk wrote:
>>
>>>Would it hard to do some memory allocation statistics, so if some
>>>process at one point (as rsync did) goes crazy eating all memory, that
>>>would be detected?
>>
>>No.  What I doubt however is whether it would be worth it,
>>since most machines never run OOM.
> 
> 
> Well, I think could be worth in terms of security, because a local user could 
> use a bad memory-eating program to produce an Denial of Service of other 
> processes.

That's what I fear.

Take the actual example. You've running a server on which people can 
connect with rsync. Somebody breaks off rsync - and the rsync-process on 
the server is getting crazy - that's the situation, I described at the 
beginning.

Now, the httpd-process on the server is killed, the named, ... .

It's a perfect DOS-attack.


Regards,
Andreas Hartmann

