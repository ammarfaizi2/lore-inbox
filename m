Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVEZMcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVEZMcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 08:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVEZMcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 08:32:11 -0400
Received: from relay3.usu.ru ([194.226.235.17]:20210 "EHLO relay3.usu.ru")
	by vger.kernel.org with ESMTP id S261351AbVEZMbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 08:31:52 -0400
Message-ID: <4295C217.2040005@ums.usu.ru>
Date: Thu, 26 May 2005 18:33:27 +0600
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bodo Eggert <7eggert@gmx.de>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
       schilling@fokus.fraunhofer.de
Subject: Re: [OT] Joerg Schilling flames Linux on his Blog
References: <4847F-8q-23@gated-at.bofh.it> <4295005F.nail2KW319F89@burner> <8E909B69-1F19-4520-B162-B811E288B647@mac.com> <200505260945.01886.patrakov@ums.usu.ru> <Pine.LNX.4.58.0505261335440.2939@be1.lrz>
In-Reply-To: <Pine.LNX.4.58.0505261335440.2939@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.16; AVE: 6.30.0.15; VDF: 6.30.0.202; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:

>So we can
>
>1) give up and let any application with write access destroy the hardware
>  
>
That won't be a problem if all apps with write access are running as 
root or setuid and thus the list of them is well-controlled by root.

>2) implement a basic filter (common for all deviced) and a device-specific 
>   filter, which can be set by a userspace application.
>  
>
In fact both approaches are used in the kernel.

(1) is used in the usbfs code, and thus SANE and gPhoto2 rely upon it 
(BTW it's still possible for a user to install an old version of SANE 
into /home/user and damage a scanner). Proper filtering in the kernel 
would be probably just too complex in this "usb generic" case.

(2) is used e.g. in DRM code.

What's missing is a clearly stated policy that says which of those two 
approaches should be applied in each particular case.

-- 
Alexander E. Patrakov

