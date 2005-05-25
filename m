Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVEYXHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVEYXHb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 19:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVEYXHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 19:07:31 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:43966 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261602AbVEYXHZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 19:07:25 -0400
Message-ID: <4294F718.8040107@ens-lyon.fr>
Date: Thu, 26 May 2005 00:07:20 +0200
From: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050417)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, pcaulfie@redhat.com, teigland@redhat.com
Subject: Re: dlm-lockspaces-callbacks-directory-fix.patch added to -mm tree
References: <200505252249.j4PMnN4q021004@shell0.pdx.osdl.net>
In-Reply-To: <200505252249.j4PMnN4q021004@shell0.pdx.osdl.net>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org wrote:
> The patch titled
> 
>      dlm build fix
> 
> has been added to the -mm tree.  Its filename is
> 
>      dlm-lockspaces-callbacks-directory-fix.patch
> 
> Patches currently in -mm which might be from alexandre.buisse@ens-lyon.fr are
> 
> dlm-lockspaces-callbacks-directory-fix.patch

Hi Andrew,
I just noticed that the line 'extern const int
dlm_lvb_operations[8][8];' had been removed in the inline patch you just
mailed.

Sorry for not making it clear in my first mail, but that definition is
needed with CONFIG_DLM_DEVICE=y. Without it, the build fails at line 362
in drivers/dlm/device.c.

Regards,
Alexandre
