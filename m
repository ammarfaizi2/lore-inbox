Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265715AbTFXGKl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 02:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265716AbTFXGKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 02:10:41 -0400
Received: from smtp-2.concepts.nl ([213.197.30.52]:22801 "EHLO
	smtp-2.concepts.nl") by vger.kernel.org with ESMTP id S265715AbTFXGKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 02:10:40 -0400
Subject: Re: 2.4.21 doesn't boot: /bin/insmod.old: file not found
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <23770.1056415063@firewall.ocs.com.au>
References: <23770.1056415063@firewall.ocs.com.au>
Content-Type: text/plain
Message-Id: <1056436551.2674.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 24 Jun 2003 08:35:52 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

On Tue, 2003-06-24 at 02:37, Keith Owens wrote:
> initrd needs the static version of insmod.  Copy /sbin/insmod.static.old
> to the ramdisk and rename it as /bin/insmod.old to suit the 2.5 modutils.

Ah, right, insmod.static.old was indeed missing, I basically assumed
it'd copy that one in automatically (since it worked for 2.4.20), but
apparently, 2.4.20 just worked for no apparent reason while it shouldn't
have.

Adding insmod.static.old to the ramdisk image (add the line 'inst
/sbin/insmod.static.old "$MNTIMAGE/bin/insmod.old"' in /sbin/mkinitrd)
fixed the issue for me. Thanks for the pointer!

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

