Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267542AbTALVuF>; Sun, 12 Jan 2003 16:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267543AbTALVuF>; Sun, 12 Jan 2003 16:50:05 -0500
Received: from matrix.roma2.infn.it ([141.108.255.2]:65195 "EHLO
	matrix.roma2.infn.it") by vger.kernel.org with ESMTP
	id <S267542AbTALVuE>; Sun, 12 Jan 2003 16:50:04 -0500
Message-ID: <32929.62.98.226.220.1042408728.squirrel@webmail.roma2.infn.it>
Date: Sun, 12 Jan 2003 22:58:48 +0100 (CET)
Subject: Re: any chance of 2.6.0-test*?
From: "Emiliano Gabrielli" <emiliano.gabrielli@roma2.infn.it>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <1042407845.3162.131.camel@RobsPC.RobertWilkens.com>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
        <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
        <20030112211530.GP27709@mea-ext.zmailer.org>
        <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
        <Pine.LNX.4.50L.0301121939170.26759-100000@imladris.surriel.com>
        <1042407845.3162.131.camel@RobsPC.RobertWilkens.com>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


<quote who="Rob Wilkens">
> On Sun, 2003-01-12 at 16:40, Rik van Riel wrote:
>> OK, now imagine the dcache locking changing a little bit.
>> You need to update this piece of (duplicated) code in half
>> a dozen places in just this function and no doubt in dozens
>> of other places all over fs/*.c.
>>
>> >From a maintenance point of view, a goto to a single block
>> of error handling code is easier to maintain.
>>
>
> There's no reason, though, that the error handling/cleanup code can't be in an
> entirely separate function, and if speed is needed, there's no reason it can't be an
> "inline" function.  Or am I oversimplifying things again?
>
> -Rob
>

you do, if you inline the code and every drive writer use this tecnique the kernel will
be much bigger don't you think ?!?

Makeing a simple function instead is quite slower I think... don't forget that goto are
used only in error recovery routines ...

You can simply build a "stack" of labels .. IMHO this is a great way to be sure of the
right order we are performing cleanup/recovery ...
-- 
Emiliano Gabrielli

dip. di Fisica
2° Università di Roma "Tor Vergata"


