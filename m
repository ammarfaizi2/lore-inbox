Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVC1VRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVC1VRw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 16:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVC1VRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 16:17:51 -0500
Received: from terminus.zytor.com ([209.128.68.124]:54147 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261505AbVC1VRs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 16:17:48 -0500
Message-ID: <4248745A.2040409@zytor.com>
Date: Mon, 28 Mar 2005 13:17:14 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: jayalk@intworks.biz, linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: [RFC 2.6.11.2 1/1] Add reboot fixup for gx1/cs5530a
References: <200503281415.j2SEFwg4014119@intworks.biz> <20050328211707.GA8240@mars.ravnborg.org>
In-Reply-To: <20050328211707.GA8240@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> 
> And hide this ifdef in same hederfile.
> 
> #ifndef CONFIG_X86_REBOOTFIXUPS
> #define mach_reboot_fixups  do {} while (0);
> #endif
> 

No semicolon; besides:

#define mach_reboot_fixups(x) ((void)0)

... is better all around.

	-hpa

