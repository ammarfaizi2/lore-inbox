Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVCLNPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVCLNPh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 08:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVCLNPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 08:15:37 -0500
Received: from relay3.usu.ru ([194.226.235.17]:26050 "EHLO relay3.usu.ru")
	by vger.kernel.org with ESMTP id S261740AbVCLNPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 08:15:33 -0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: current linus bk, error mounting root
Date: Sat, 12 Mar 2005 18:15:30 +0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503121815.30434.patrakov@ums.usu.ru>
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.16; AVE: 6.30.0.5; VDF: 6.30.0.26; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:

> Here's a big clue, if I build ata_piix in I can boot. If it is a
> module I can't. The console output definitely shows that the module is
> being loaded.

Of course I am not an expert here, but I want to rule out some trivial 
userspace things first.

Some time ago Greg KH said that even when the modprobe command returns, there 
is no guarantee that the module finished hardware detection. By rebuilding 
ata_piix as a non-module, you changed the timeline.

Could you please, for debugging, recompile ata_piix as a module again, but add 
a "sleep 5" before the mkrootdev command? If that works, a bug (race) is 
officially in userspace.

Sorry if all of the above is in fact just meaningless noise.

-- 
Alexander E. Patrakov
