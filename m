Return-Path: <linux-kernel-owner+w=401wt.eu-S1160997AbWLTWz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160997AbWLTWz4 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160998AbWLTWz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:55:56 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:60812 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1160997AbWLTWzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:55:55 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4589BF62.4050105@s5r6.in-berlin.de>
Date: Wed, 20 Dec 2006 23:55:30 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
       Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/4] Add core firewire stack.
References: <20061220005827.GC11746@devserv.devel.redhat.com>
In-Reply-To: <20061220005827.GC11746@devserv.devel.redhat.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Høgsberg wrote:
> Signed-off-by: Kristian Hoegsberg <krh@redhat.com>
> ---
>  drivers/Kconfig                   |    2 
>  drivers/Makefile                  |    1 
>  drivers/firewire/Kconfig          |   23 +
>  drivers/firewire/Makefile         |    7 
>  drivers/firewire/fw-card.c        |  384 +++++++++++++++++++
>  drivers/firewire/fw-iso.c         |  136 +++++++
>  drivers/firewire/fw-topology.c    |  446 +++++++++++++++++++++++
>  drivers/firewire/fw-topology.h    |   84 ++++
>  drivers/firewire/fw-transaction.c |  730 +++++++++++++++++++++++++++++++++++++
>  drivers/firewire/fw-transaction.h |  422 +++++++++++++++++++++
>  10 files changed, 2235 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index e7da9fa..c651556 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -30,6 +30,8 @@ source "drivers/md/Kconfig"
>  
>  source "drivers/message/fusion/Kconfig"
>  
> +source "drivers/firewire/Kconfig"
> +
>  source "drivers/ieee1394/Kconfig"
>  
>  source "drivers/message/i2o/Kconfig"
[...]

Would anybody mind if I pick this up for linux1394-2.6.git's master
branch? --- This would mean it appears in the next -mm.


(Personally, I would prefer it being stuffed into drivers/ieee1394, thus
preparing for a _potential_ point in time when the kernel config option
of old stack vs. new stack vs. both stacks condenses to a radio button
in a single IEEE 1394 config menu, and for a potential brief period
during which both stacks live in mainline together that way. But if
nobody else complains, I'll include it as drivers/firewire.)
-- 
Stefan Richter
-=====-=-==- ==-- =-=--
http://arcgraph.de/sr/
