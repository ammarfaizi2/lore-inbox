Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVLBQqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVLBQqK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 11:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVLBQqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 11:46:10 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:57078 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750820AbVLBQqJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 11:46:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i/M5C3M6xNy4QoHrbM6+MNfew/3plxzjotuQN0DZMWmjX+Q+DvIUdeCHsaoHNpp1JYlmjKWE9CIJj+6GctYmsLgLHh2JhWzE10ye3RYsE7ew6zVVTAyoRvZPnPDXRrb38v4k4pJrSabOhzEtgAsAa3/HqaIviwaF3mITt3IH1GA=
Message-ID: <d120d5000512020846m6b8060f3o7945a4d3741fc95d@mail.gmail.com>
Date: Fri, 2 Dec 2005 11:46:08 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Yu, Luming" <luming.yu@intel.com>
Subject: Re:
Cc: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC237@pdsmsx403>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3ACA40606221794F80A5670F0AF15F84041AC237@pdsmsx403>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/05, Yu, Luming <luming.yu@intel.com> wrote:
> I just tested module wistron_btn on  one Acer Aspire laptop after
> adding one dmi entry.  The wistron_btn found BIOS interfaces.
> One visible error is the bluetooth light won't turn on upon
> stroking bluetooth button.
> Without wistron_btn module, the bluetooth light works.
>  with acpi enabled, I didn't try acpi disabled)
>

Did you add the new keymap table with KE_BLUETOOTH to go with that DMI entry?

> wistron_btn polls a cmos address to detect hotkey event.  It
> is not necessary, because there do have ACPI interrupt triggered upon
> hotkeys.
>

Unfortunately ACPI does not route these events through the input layer
so aside from special buttons (like sleep) it is not very useful.

> So, my suggestion is to disable this module when ACPI enabled.
> We need to implement hotkey support from ACPI subsystem for my
> Acer aspire laptop.

I do not agree.

--
Dmitry
