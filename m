Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264751AbTFEQfQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 12:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264756AbTFEQfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 12:35:16 -0400
Received: from mail.convergence.de ([212.84.236.4]:5559 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S264751AbTFEQfP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 12:35:15 -0400
Message-ID: <3EDF742C.2040500@convergence.de>
Date: Thu, 05 Jun 2003 18:47:40 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: Gregoire Favre <greg@magma.unil.ch>
CC: linux-kernel@vger.kernel.org, linux-dvb@linuxtv.org
Subject: Re: [linux-dvb] Re: Can't boot since 2.4.21-rc2-ac3 with dvb-kernel
References: <20030602171613.GA1609@magma.unil.ch> <20030605163932.GA17573@magma.unil.ch>
In-Reply-To: <20030605163932.GA17573@magma.unil.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gregoire,

> as already repported with older ac and older CVS of dvb-kernel, same
> Oops with 2.4.21-rc7-ac1:

Are you sure you have used the v4l2 "videodev.o" (backported from 2.5) 
that comes from the "build-2.4" directory from the "dvb-kernel" cvs tree?

 > Trace; fab4a2bb <[videodev]video_open+182/1d2>
 > Trace; c0144dce <cached_lookup+18/5b>
 > Trace; c0145626 <link_path_walk+616/6b8>

This looks suspicious...

Please do a
 > find /lib/modules/ -iname "*videodev*"

If you have a "videodev.o" in .../kernel/drivs/media/video, then this 
will be used. But this is the plain old 2.4 video4linux-*1* videodev 
module, which does not work in conjunction with the "dvb-kernel" CVS 
driver, which needs the 2.5 video4linux-*2* videodev.

> 	Grégoire

Please don't CC the linux kernel mailing list the next time, since this 
is a dvd only issue. Thanks!

CU
Michael.


