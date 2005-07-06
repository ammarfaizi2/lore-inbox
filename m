Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVGFSyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVGFSyk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 14:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVGFSyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 14:54:39 -0400
Received: from [195.23.16.24] ([195.23.16.24]:24764 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262017AbVGFNpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 09:45:31 -0400
Message-ID: <42CBE05F.4090706@grupopie.com>
Date: Wed, 06 Jul 2005 14:45:03 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexis Ballier <alexis.ballier@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13-rc2 - Inconsistent kallsyms data
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org>	 <42CB8088.1090508@ppp0.net> <ea6b190205070602091b50e204@mail.gmail.com>
In-Reply-To: <ea6b190205070602091b50e204@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexis Ballier wrote:
> Hi ! 
> 
> I have a problem building the rc2 (or rc3, whatever ;) )
> 
> Here is the end of the log : 
> 
> [...]
> Inconsistent kallsyms data
> Try setting CONFIG_KALLSYMS_EXTRA_PASS
> make: *** [vmlinux] Erreur 1

Can you try to change this setting in scripts/kallsyms.c:

#define WORKING_SET		1024

to somethig like:

#define WORKING_SET	       65536

If this fixes it, then it is a known problem and the fix is already in 
-mm. The fix is more complex than this, however.

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams
