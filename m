Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbTIEKsJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 06:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbTIEKsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 06:48:09 -0400
Received: from mail.netbeat.de ([62.208.140.19]:61968 "HELO mail.netbeat.de")
	by vger.kernel.org with SMTP id S262481AbTIEKsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 06:48:05 -0400
Subject: Re: 2.6.0-test4-mm6
From: Jan Ischebeck <mail@jan-ischebeck.de>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: text/plain
Message-Id: <1062758896.2085.19.camel@JHome.uni-bonn.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 05 Sep 2003 12:48:16 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 September 2003 16:59, Andrew Morton wrote:
>
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm6/
>

Hi Andrew,

Some first impressions:

1. swsusp works great (Thinkpad R40 2722)

2. X11R6 won't start anymore, it fails with a strange 
Fatal server error:
xf86OpenConsole: VT_GETMODE failed
I can't find a reason for that in the changelog.

3. The oss mixer emulation doesn't load correctly, I get the following
messages in the syslog, f.e. after a "modprobe snd-mixer-oss":

snd: Unknown parameter `device_mode'
snd_mixer_oss: Unknown symbol snd_info_register
snd_mixer_oss: Unknown symbol snd_info_free_entry
snd_mixer_oss: Unknown symbol snd_info_get_str
snd_mixer_oss: Unknown symbol snd_unregister_oss_device
snd_mixer_oss: Unknown symbol snd_ctl_find_id
snd_mixer_oss: Unknown symbol snd_register_oss_device
snd_mixer_oss: Unknown symbol snd_card_file_add
snd_mixer_oss: Unknown symbol snd_mixer_oss_notify_callback
snd_mixer_oss: Unknown symbol snd_iprintf
snd_mixer_oss: Unknown symbol snd_kcalloc
snd_mixer_oss: Unknown symbol snd_cards
snd_mixer_oss: Unknown symbol snd_ctl_notify
snd_mixer_oss: Unknown symbol snd_oss_info_register
snd_mixer_oss: Unknown symbol snd_kmalloc_strdup
snd_mixer_oss: Unknown symbol snd_info_create_card_entry
snd_mixer_oss: Unknown symbol snd_card_file_remove
snd_mixer_oss: Unknown symbol snd_info_unregister
snd_mixer_oss: Unknown symbol snd_info_get_line

Could be connected with 
> +sound-remove-duplicate-includes.patch
> +kernel-remove-duplicate-includes.patch
> 
> janitorial work

4. Powerdown via ACPI still doesn't work (broken since -test2 or -test1)

Thanks for the great work.

Jan

(Please CC me on reply)

-- 
Jan Ischebeck <mail@jan-ischebeck.de>

