Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWBAB3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWBAB3N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 20:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWBAB3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 20:29:13 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:6740 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964808AbWBAB3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 20:29:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=j9/KNsb7ELWU9YS1vbU9g+yXnBi2wcemRqGKb0mN0VThQB7wwbNjz+DQl6nDh4430VDgj9LFhKjRM6e2Yo7R+8px1Td6ZDNQwJBfczW0QvFE93hlkfKqCvuaUMx6svH/AaJSUHBjvIzldXqJ9AaX7vYWRwGscdZyGmMWN5x8G78=
Date: Wed, 1 Feb 2006 04:47:21 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: 2.6.16-rc1-mm4: ALSA oops at remove_proc_entry
Message-ID: <20060201014721.GA7720@mipter.zuzino.mipt.ru>
References: <20060129144533.128af741.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060129144533.128af741.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My bisect script told me that

Sucker is git-alsa.patch
---------------------------------------------
EIP is at remove_proc_entry
Process rmmod

snd_info_unregister		[snd]
snd_pcm_oss_proc_done		[snd_pcm_oss]
snd_pcm_oss_unregister_minor	[snd_pcm_oss]
snd_pcm_notify			[snd_pcm]
sys_delete_module
do_munmap
syscall_call

.config
-------
CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
# CONFIG_SND_PCM_OSS_PLUGINS is not set
# CONFIG_SND_RTCTIMER is not set
# CONFIG_SND_DYNAMIC_MINORS is not set
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_VERBOSE_PROCFS is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
CONFIG_SND_INTEL8X0=m

