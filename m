Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbUJZIdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbUJZIdY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 04:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUJZIdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 04:33:23 -0400
Received: from host-ip82-243.crowley.pl ([62.111.243.82]:3336 "HELO
	software.com.pl") by vger.kernel.org with SMTP id S262186AbUJZIdK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 04:33:10 -0400
From: Karol Kozimor <kkozimor@aurox.org>
Organization: Aurox Sp. z o.o.
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
Date: Tue, 26 Oct 2004 10:32:47 +0200
User-Agent: KMail/1.7
Cc: Stelian Pop <stelian@popies.net>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
References: <200410210154.58301.dtor_core@ameritech.net> <20041025135036.GA3161@crusoe.alcove-fr> <20041025221238.GB5207@elf.ucw.cz>
In-Reply-To: <20041025221238.GB5207@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410261032.47467.kkozimor@aurox.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 of October 2004 00:12, Pavel Machek wrote:
> > * allocate a FN key event and let FN be a modifier.
> >
> >   This is much nicer (less events allocated in input.h), but I haven't
> >   found a way (and I'm not sure there is one) to say to X that Fn is
>
> I think this is *bad* idea. In such case, userland would see
> Fn-F3. My notebook has "sleep" key on Fn-F3, but your notebook
> probably has something else there. You'd need another mapping in
> userspace...
>
> I believe Fn-F3 on my machine is meant to be replacement for hardware
> sleep button (and it has sleep label on it!), and we really should
> generate sleep event for Fn-F3...

Then map the button to invoke the suspend script in userspace. First we're 
mapping ACPI events to input events, then the other way around? Sounds 
fishy to me.
Best regards,

-- 
Karol Kozimor
kkozimor@aurox.org
