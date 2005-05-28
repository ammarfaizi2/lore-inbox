Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262601AbVE1ALq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbVE1ALq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 20:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVE1ALq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 20:11:46 -0400
Received: from smtp05.auna.com ([62.81.186.15]:17338 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S262601AbVE1ALn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 20:11:43 -0400
Date: Sat, 28 May 2005 00:11:42 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-rc3-mm3: ALSA broken ?
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
References: <20050504221057.1e02a402.akpm@osdl.org>
	<1115510869l.7472l.0l@werewolf.able.es>
	<1115594680l.7540l.0l@werewolf.able.es> <s5hd5rx2656.wl@alsa2.suse.de>
	<1115936836l.8448l.1l@werewolf.able.es> <s5hvf5nsb2r.wl@alsa2.suse.de>
	<1116331359l.7364l.0l@werewolf.able.es> <s5hll6eoxhf.wl@alsa2.suse.de>
	<1116369585l.8840l.0l@werewolf.able.es> <s5hoeb8sleq.wl@alsa2.suse.de>
	<1117151518l.7637l.0l@werewolf.able.es>
	<1117205521.13829.59.camel@mindpipe>
In-Reply-To: <1117205521.13829.59.camel@mindpipe> (from rlrevell@joe-job.com
	on Fri May 27 16:52:01 2005)
X-Mailer: Balsa 2.3.2
Message-Id: <1117239102l.9264l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.219.120] Login:jamagallon@able.es Fecha:Sat, 28 May 2005 02:11:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.27, Lee Revell wrote:
> On Thu, 2005-05-26 at 23:51 +0000, J.A. Magallon wrote:
> > - When linking I got:
> > if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map
> > 2.6.11-jam20; fi
> > WARNING: /lib/modules/2.6.11-jam20/kernel/sound/soundcore.ko needs unknown
> > symbol class_simple_device_add
> > WARNING: /lib/modules/2.6.11-jam20/kernel/sound/soundcore.ko needs unknown
> > symbol class_simple_destroy
> > WARNING: /lib/modules/2.6.11-jam20/kernel/sound/soundcore.ko needs unknown
> > symbol class_simple_device_remove
> > WARNING: /lib/modules/2.6.11-jam20/kernel/sound/soundcore.ko needs unknown
> > symbol class_simple_create
> > WARNING: /lib/modules/2.6.11-jam20/kernel/sound/core/snd.ko needs unknown
> > symbol class_simple_device_add
> > WARNING: /lib/modules/2.6.11-jam20/kernel/sound/core/snd.ko needs unknown
> > symbol class_simple_device_remove
> > 
> > I think all this have been unexported/killed...
> 
> Really?  I thought only unused EXPORT_SYMBOLS were being killed.
> 
> Lee
> 

werewolf:/usr/src/linux-2.6.12-rc5-mm1# grep -r class_simple_create *
werewolf:/usr/src/linux-2.6.12-rc5-mm1# 

nothin, nada, rien.
They are present in mainline, but dissapeared in -mm.

As I see in -mm patch, it is as simple as s/class_simple/class/.
When will this reach mainline, who knows...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam20 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


