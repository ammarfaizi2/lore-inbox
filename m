Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVC1VPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVC1VPe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 16:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVC1VPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 16:15:34 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:63881 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262080AbVC1VPa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 16:15:30 -0500
Date: Mon, 28 Mar 2005 23:17:07 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: jayalk@intworks.biz
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: [RFC 2.6.11.2 1/1] Add reboot fixup for gx1/cs5530a
Message-ID: <20050328211707.GA8240@mars.ravnborg.org>
References: <200503281415.j2SEFwg4014119@intworks.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503281415.j2SEFwg4014119@intworks.biz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small comments below.

>  
> +#ifdef CONFIG_X86_REBOOTFIXUPS
> +extern void mach_reboot_fixups(void);
> +#endif
Move this to header file.

> +#ifdef CONFIG_X86_REBOOTFIXUPS
> +			mach_reboot_fixups();
> +#endif
And hide this ifdef in same hederfile.

#ifndef CONFIG_X86_REBOOTFIXUPS
#define mach_reboot_fixups  do {} while (0);
#endif

	Sam
