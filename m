Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVC1LIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVC1LIi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 06:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVC1LIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 06:08:38 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:50719 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261516AbVC1LIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 06:08:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=Afc/FdL6PtXWi2yY7xn5co+4acWriyCruUTnYkKVPm4UMOjoIrMQOQmugV6l6AB+T6GSufZ4aNHs0SmJu9q22bfPnUwSNCBZh1s8Sfm1SRUGxsLbuBDvmEmoAD5GZeurSmt/P8yEkINck+kungicyJvf6Sj+LfBH8IqddtJP15Y=
Message-ID: <84fecab05032803082415448f@mail.gmail.com>
Date: Mon, 28 Mar 2005 13:08:05 +0200
From: Valery Khamenya <khamenya@gmail.com>
Reply-To: Valery Khamenya <khamenya@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: reboot problem with VIA EPIA-MS motherboard
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

please Cc to me your clues on the following problem:

Symptom:

"reboot" or "shutdown -r now" on VIA EPIA-MS motherboard finishes all 
processes, then comes message "Restarting system.", keyboard LEDs 
flash and nothing happens anymore -- one has to finalize reboot manually.

Comments:

1. Motherboard is really able to reboot: e.g. when after POST comes grub, one
could enter grub's console and issue "reboot" -- it works fine.

2. different kernel boot options were tried without success, like
"reboot=b|w|h|c", "acpi=on|off|force", "apm=on|off" -- not in
all combinations though ;)

3. Linux distro used -- Gentoo. (synced)

4. different 2.6.x kernel were tried: 2.6.9-2.6.12, not only vanilla kernels,
but Gentoo kernels too. (Now I am stuck to 2.6.12-rc1 as it is exposed via 
Gentoo portage system)

5. different kernel boot options lead to different reboot implementations.
One of tracked by me implementations ends up in
mach-default/mach_reboot.h, inlined function "mach_reboot".
The second udelay(50) in the loop is the last call,
after which nothing happens anymore. 

6. Any other details/logs might be posted -- just tell me
which are of interest.

TIA,
Valery.

P.S. perhaps, I do not violate any rules posting my problem and comments
to this malinglist.
-- 
Valery A.Khamenya
