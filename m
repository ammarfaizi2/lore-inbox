Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262814AbVBZBN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbVBZBN3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 20:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVBZBMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 20:12:46 -0500
Received: from mail.goracer.de ([62.75.192.134]:13795 "HELO mail.goracer.de")
	by vger.kernel.org with SMTP id S262818AbVBZBIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 20:08:14 -0500
Message-ID: <421FCBF9.1020003@XLsigned.net>
Date: Sat, 26 Feb 2005 02:08:09 +0100
From: "Buttchereit, Axel (XL)" <XL@XLsigned.net>
Organization: XLsigned - Information Content
User-Agent: Mozilla Thunderbird 0.8 (X11/20040925)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: Olaf Hering <olh@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: 2.6.11-rc5
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <20050224145049.GA21313@suse.de> <20050226004137.GA25539@suse.de> <Pine.LNX.4.58.0502251648420.9237@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0502251648420.9237@ppc970.osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 26 Feb 2005, Olaf Hering wrote:
> 
>>modedb can not be __init because fb_find_mode() may get db == NULL.
>>fb_find_mode() is called from modules.
> 
> 
> Ack. Maybe somebody should run the scripts again to check that we don't 
> reference __init data from non-init functions.
> 
> 		Linus
> 
This patch has already been posted to linux-fbdev on 2005-02-10 by David Vrabel
and made me ask
	Is there any reason why this has been originally flagged "__init"?
	"vesa_modes" is not "__init". That's why I changed "intelfb" to
	use "vesa_modes".

Maybe time has come to decide, if availability of "modedb" outside
of init functions is more important than freeing (unused) kernel memory.

--Axel



  

  
