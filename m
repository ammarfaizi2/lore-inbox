Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbUDTMgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbUDTMgr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 08:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUDTMgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 08:36:47 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:20147 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262882AbUDTMgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 08:36:45 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux problem (2.6.5)
Date: Tue, 20 Apr 2004 07:35:44 -0500
User-Agent: KMail/1.6.1
Cc: "E.Rodichev" <er@sai.msu.su>
References: <Pine.GSO.4.58.0404200404360.22353@ra.sai.msu.su>
In-Reply-To: <Pine.GSO.4.58.0404200404360.22353@ra.sai.msu.su>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404200736.38616.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 April 2004 07:26 pm, E.Rodichev wrote:

> The reason is that in 2.6.5 it looks impossible to disable the existing
> mouse driver, which conflicts with driver from Tuukka Toivonen. My
> temporary solution was as follows:
> 
> 
> --- drivers/input/Kconfig.orig ?2004-04-04 07:36:18.000000000 +0400
> +++ drivers/input/Kconfig ? ? ? 2004-04-20 03:45:31.000000000 +0400
> @@ -26,7 +26,6 @@ comment "Userland interfaces"
> 
> ?config INPUT_MOUSEDEV
> ? ? ? ? tristate "Mouse interface" if EMBEDDED
> - ? ? ? default y
> ? ? ? ? depends on INPUT
> ? ? ? ? ---help---
> ? ? ? ? ? Say Y here if you want your mouse to be accessible as char devices
> 

Ok, I am slow today, but how does mousedev affect his psaux implementation?
I can see that his module can conflict with psmouse (which is configurable),
but mousedev?

The reason it is always on because it is useful for any kind of mouse -
serial, USB, PS/2. You really want to keep it around...

-- 
Dmitry
