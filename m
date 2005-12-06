Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751701AbVLFPVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbVLFPVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 10:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbVLFPVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 10:21:10 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:9129 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751701AbVLFPVI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 10:21:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NDEFP3oJoxdKeGO4KVH0WAJenBmCeZrato3SUwc/Z5b2p3k0e8Ze3LkIWhygv0v36j/Y67ovmO+mCx9jo6MmOr1J9MUvTMB8Gn6vJ7th2oFktT2Ffy++yjyakJRP2zJ8qGLGDHqYzni0zmmo8A88tz+wSrTI2PxhE8diWvQVrXE=
Message-ID: <d120d5000512060721j3a75ff7bh40309f4fa132b39a@mail.gmail.com>
Date: Tue, 6 Dec 2005 10:21:07 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Yu, Luming" <luming.yu@intel.com>
Subject: Re: [git pull 02/14] Add Wistron driver
Cc: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>,
       Bernhard Rosenkraenzer <bero@arklinux.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840A53FCC5@pdsmsx403>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3ACA40606221794F80A5670F0AF15F840A53FCC5@pdsmsx403>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/05, Yu, Luming <luming.yu@intel.com> wrote:
> >> wistron_btn polls a cmos address to detect hotkey event.  It
> >> is not necessary, because there do have ACPI interrupt triggered upon
> >> hotkeys.
> >>
> >
> >Unfortunately ACPI does not route these events through the input layer
> >so aside from special buttons (like sleep) it is not very useful.
>
> There are acpi daemon for any evetnts that needs user space attention.
> I'm not sure if these events should be routed to input layer.

How do you suggest handle buttons such as "Mail", "WWW", etc? Through
acpid? And then tunnel them to X somewhow?

> But, we can do that.
>
> >
> >> So, my suggestion is to disable this module when ACPI enabled.
> >> We need to implement hotkey support from ACPI subsystem for my
> >> Acer aspire laptop.
> >
> >I do not agree.
>
> For my acer aspire laptop.
> I added dmi entry, and keymap.
>
> With acpi disabled, bluetooth light doesn't work
> With acpi disabled + wistron module,  bluetooth light doesn't work.
>
> With acpi enabled +  wistron module,  bluetooth light doesn't work
>
> With acpi enabled - wistron module, bluetooth works.
> From these test cases, do you still think wistron driver can help my
> laptop?
>

No, you have proven that the driver will not help to your laptop. Now,
as it is, it won't even load on your laptop either, because of
different DMI signature. So why are you complaining? I am pretty sure
Bernhard (who added bluetooth handling) has his working with ACPI.
Bernhard, any input on this?

--
Dmitry
