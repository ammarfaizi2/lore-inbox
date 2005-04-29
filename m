Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262809AbVD2QEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262809AbVD2QEP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 12:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVD2QEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 12:04:14 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:53539 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262814AbVD2QD3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 12:03:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JlVWI9W/EzAGdS1FbZRMfqmWUY5JonkmFSuMPKyTEXemp7NBVOPMd8Mjsmozc15OH/8UQmUVHwKbxQomjw8X3OO0FGYgYwNlmuG+7IazyK2tCJOVh2Dw4tN9gKHHkMG5UjGtOgWHNHkhfFJIby2WTt0JMNqQu//yXyN+gk/VRjw=
Message-ID: <d120d5000504290903758bc9f2@mail.gmail.com>
Date: Fri, 29 Apr 2005 11:03:24 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
Subject: Re: Serial Mouse in Kernel 2.6
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050429145248.3551b9ea.Christoph.Pleger@uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050429145248.3551b9ea.Christoph.Pleger@uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/29/05, Christoph Pleger <Christoph.Pleger@uni-dortmund.de> wrote:
> Hello,
> 
> When configuring Kernel 2.6.11.7, I found under Input Devices two
> options which seem to have to do with serial mouse support:
> 
> 1. Serial line discipline (module serport)
> 2. Serial Mouse support (module sermouse)
> 
> Ic compiled both these features as a module. But after rebooting with
> the new kernel, the serial mouse is working well with gpm and with X11,
> although none of the above modules are loaded.
> 
> So, what for are the modules mentioned above needed?
> 

If you load the modules and use input_attach program to set up your
mouse then you can access it via /dev/input/mice together with the
rest of you mice, PS/2, USB, etc. This way you have only one input
device for you mouse and do not have to change millions of programs
(actually 2) if you happen to install a new mouse.

You seem to still using the mouse by accessing /dev/ttySx port and
using serial mouse driver.

-- 
Dmitry
