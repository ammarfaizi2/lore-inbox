Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262859AbVCMEUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbVCMEUW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 23:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbVCMELx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 23:11:53 -0500
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:62129 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262736AbVCMD7y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 22:59:54 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [PATCH 0/5] I8K driver facelift
Date: Sat, 12 Mar 2005 22:59:49 -0500
User-Agent: KMail/1.7.2
Cc: LKML <linux-kernel@vger.kernel.org>, Massimo Dal Zotto <dz@debian.org>
References: <200502240110.16521.dtor_core@ameritech.net> <4233B65A.4030302@tuxrocks.com>
In-Reply-To: <4233B65A.4030302@tuxrocks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503122259.52855.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 March 2005 22:41, Frank Sorenson wrote:
> Dmitry Torokhov wrote:
> | Hi,
> |
> | here are some changes that freshen I8K driver (Dell Inspiron/Latitude
> | platform driver). The patches have been tested on Inspiron 8100.
> <snip>
> | Please consider for inclusion.
> |
> | Thanks!
> 
> These patches look pretty good.  A few comments (with a patch--tested on
> my Inspiron 9200):
> 
> - The "return i8k_smm(&regs) < 0 ? : regs.eax;" construction is nice and
> tidy, but it isn't passing on the return value of the called function,
> and is returning TRUE or 1 on failure.  This makes it difficult to check
> the return value for valid data.  Old behavior returned negative, so
> I'll return -1.

Hi,

Actually I am not sure what I was thinkinhg when I wrtote it, the correct
version should be "return i8k_smm(&regs) ? : regs.eax;" since i8k_smm
return 0 on success.

I will think about dynamically adding attributes...

-- 
Dmitry
