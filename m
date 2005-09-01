Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030378AbVIAU3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbVIAU3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbVIAU3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:29:08 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:50446 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S1030375AbVIAU3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:29:07 -0400
Message-ID: <43176488.2080608@rulez.cz>
Date: Thu, 01 Sep 2005 22:28:56 +0200
From: iSteve <isteve@rulez.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SysFS, module names and .name
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
in sysfs, /sys/bus/*/drivers lists the driver names, with their exported 
.name (eg. '.name = "EMU10K1_Audigy"' in the module code, from now on 
'driver name'). In /sys/modules, the kernel modules are listed with 
their module name, eg. snd_emu10k1. However, it seems to me that in 
sysfs, there is no way in particular to tell, which module has which 
.name. That is, that snd_emu10k1 is EMU10K1_Audigy and vice versa.

I wonder whether it wouldn't be possible to add a symlink to the 
particular module from the driver, and/or from the module to the driver, 
so the list of devices handled by the module and the module name would 
be accessible. This way, I would know which driver name corresponds to 
which module name and vice versa.

Or am I just boldly missing something, and there is a way how to do this 
from userspace, preferably without reading /proc/kcore?

Thanks in advance for reply.

  - iSteve
