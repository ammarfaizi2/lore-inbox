Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291679AbSBNOac>; Thu, 14 Feb 2002 09:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291687AbSBNOaX>; Thu, 14 Feb 2002 09:30:23 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:57310 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S291679AbSBNOaM>;
	Thu, 14 Feb 2002 09:30:12 -0500
Date: Thu, 14 Feb 2002 15:30:04 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200202141430.PAA28313@harpo.it.uu.se>
To: thomas@langaas.org
Subject: Re: inspiron 8100 freezing
Cc: ieure@qwest.net, linux-kernel@vger.kernel.org,
        linux-laptops@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2002 11:48:56 +0100, Thomas Langås wrote:
>Mikael Pettersson:
>> I bet you have CONFIG_SMP or CONFIG_X86_UP_APIC enabled. In that
>> case the hangs on the Inspiron are expected: it's BIOS is buggy.
>
>Ok, what's wrong?  Just telling them something is wrong with their BIOS
>doesn't do much good :)

The machine ships with a CPU containing a local APIC, but if
Linux enables it, the machine hangs when the BIOS is entered,
i.e. at power management events and entry to BIOS setup screens.

On other machines that don't hang, the BIOS either handles the
local APIC itself, or it invokes the kernel's APM callback which
disables the local APIC before e.g. doing a suspend.

/Mikael
