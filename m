Return-Path: <linux-kernel-owner+willy=40w.ods.org-S520735AbUKBEYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S520735AbUKBEYG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 23:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S310142AbUKBEYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 23:24:05 -0500
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:38479 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S318062AbUKBESt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 23:18:49 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Map extra keys on compaq evo
Date: Mon, 1 Nov 2004 23:18:45 -0500
User-Agent: KMail/1.6.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <20041031213859.GA6742@elf.ucw.cz> <20041101140717.GA1180@ucw.cz> <20041101172809.GB23341@elf.ucw.cz>
In-Reply-To: <20041101172809.GB23341@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411012318.45690.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 November 2004 12:28 pm, Pavel Machek wrote:
> Hi!
> 
> > > With accurate list "hotkeys" could run with no configuration, but I am
> > > afraid maintaining accurate list of keys for each keyboard is way too
> > > much work.
> > 
> > The lists need to be kept _somewhere_, so why not have a userspace
> > database with a program that loads the description into the kernel at
> > boot, possibly using DMI as a hint to what keyboard is connected?
> 
> Doing dmi blacklist from userspace is going to be pretty
> painfull... Kernel already has all the infrastructure.
> 
> My preference is forget about providing list of keys (it never worked
> anyway), and just fixup few notebooks we know...

What about all those "multimedia" and "Internet" keyboards out there?

Plus I don't think using DMI is a good idea. Many people use 2 keyboards
with their laptops - built-in and external and DMI mapping will sure be
wrong for external keyboard. Theoretically it should be possible to have
several completely independent keyboards (at least as far as keycodes go).

I actually would love to set up X to have 2 keyboards with 2 different
layouts, I wonder if event keyboard driver can help here... And we'd have
to adjust setkeycodes too...

-- 
Dmitry
