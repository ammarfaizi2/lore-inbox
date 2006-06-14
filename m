Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWFNRGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWFNRGZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 13:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWFNRGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 13:06:25 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:42504 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1750707AbWFNRGZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 13:06:25 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: 2.6.16.19 + gcc-4.1.1
Date: Wed, 14 Jun 2006 18:06:25 +0100
User-Agent: KMail/1.9.3
Cc: Brice Goglin <Brice.Goglin@ens-lyon.org>, Avuton Olrich <avuton@gmail.com>,
       Russell Whitaker <russ@ashlandhome.net>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.63.0606131906230.2368@bigred.russwhit.org> <448F8C53.5010406@ens-lyon.org> <Pine.LNX.4.61.0606141132190.5349@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0606141132190.5349@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606141806.25124.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 June 2006 10:33, Jan Engelhardt wrote:
> >Actually, "make modules" does not exist anymore with 2.6. Both built-in
> >and modular stuff are built at the same time.
> >Only "make modules_install" is still required.
>
> You can _still_ build bzImage and modules separately.
>
> The _default_ kernel Makefile target though reads (sth. like)
>
> all: bzImage modules

Maybe for consistency with other packages, the default "make install" should 
imply modules_install too.

I know you can hack around this with /sbin/installkernel (on at least x86 and 
x86_64), but it's counterintuitive. I guess the reason is that 'install' has 
always meant "just the bzImage please", and sometimes it's valid to install 
only a bzImage without reinstalling modules. However, it just leads to 
problems such at the original poster's.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
