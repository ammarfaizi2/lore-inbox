Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWEZHIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWEZHIU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWEZHIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:08:20 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:3486 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751332AbWEZHIT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:08:19 -0400
Message-ID: <4476A8AA.1010106@aitel.hist.no>
Date: Fri, 26 May 2006 09:05:14 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Xavier Bestel <xavier.bestel@free.fr>
CC: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       Matheus Izvekov <mizvekov@gmail.com>, Jon Smirl <jonsmirl@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>	 <200605230048.14708.dhazelton@enter.net>	 <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>	 <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com>	 <44740533.7040702@aitel.hist.no> <447465C6.3090501@ums.usu.ru>	 <9e4733910605240749r1ce9e9fehcfffb2f2e3aeab60@mail.gmail.com>	 <44747432.1090906@ums.usu.ru>	 <305c16960605240915p7961ddbfye90afd3cf7fbc372@mail.gmail.com>	 <4474891D.9010205@ums.usu.ru> <1148492064.16503.1.camel@bip.parateam.prv>
In-Reply-To: <1148492064.16503.1.camel@bip.parateam.prv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel wrote:
> Don't save the framebuffer. Just send a message to the client
> application saying "fb is corrupted, please redraw". X11 can do it,
> console can do it.
>   
Sure, X has no problem doing an expose event on the entire screen.
But then the kernel would need a way to tell X that the display
was invalidated outside its control.  Is there even an
API for that today?

The problem isn't trivial, for the machine may be running
quite a few xservers.  Or some other sort of software
that uses the framebuffer.  (libsvga, y, berlin, ...)

Helge Hafting
