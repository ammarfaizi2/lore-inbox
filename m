Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVBYVor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVBYVor (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 16:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbVBYVor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 16:44:47 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:34691 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261894AbVBYVoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 16:44:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KAW6DIOx7O1JPIGnkEo/d8pdT5T8ZWY4kUFN8jQ0wUQYp3zJ9K28n20EPFpB01CHu6V8PsD9aO3N9CaoThykNL31gVSzZyzSt7l9uDLxd/p+lQJGePa6u76p3RSkWG/kRNocZyJslDZd2xn8ICoE5yYDSd/a5MIyCUJJQ/I3wOQ=
Message-ID: <d120d500050225134468f8ffac@mail.gmail.com>
Date: Fri, 25 Feb 2005 16:44:39 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Johan Braennlund <johan_brn@yahoo.com>
Subject: Re: ALPS touchpad not seen by 2.6.11 kernels
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050225213336.58742.qmail@web50203.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050225213336.58742.qmail@web50203.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2005 13:33:36 -0800 (PST), Johan Braennlund
<johan_brn@yahoo.com> wrote:
> Hi. I've had trouble with my ALPS touchpad on my Acer Aspire, ever
> since ALPS support was merged into the kernel. I've tried various
> kernels from 2.6.11-rc3 to -rc5 (including some -mm kernels) and none
> of them detect the pad. After sprinkling some printk's in the mouse
> drivers, it seems like psmouse_connect in psmouse-base.c is never even
> called.
> 
> On the other hand, using earlier kernels (such as 2.6.9) with the
> kernel patch from Peter Osterlund's driver package works fine. In that
> case, I get lines like this in syslog:
> 
> kernel: alps.c: E6 report: 00 00 64
> kernel: alps.c: E7 report: 73 02 14
> kernel: alps.c: E6 report: 00 00 64
> kernel: alps.c: E7 report: 73 02 14
> kernel: alps.c: Status: 15 01 0a
> kernel: ALPS Touchpad (Glidepoint) detected
> kernel: input: AlpsPS/2 ALPS TouchPad on isa0060/serio4
> 
> With the newer kernels, there's nothing ALPS-related in the log. Any
> pointers on what to look for would be appreciated. My kernel config is
> at http://nullinfinity.org/config-2.6.11-rc5
> 

Hi,

Does i8042 detect presence of an AUX port (check dmesg)? If not try
booting with i8042.noacpi kernel boot option.

-- 
Dmitry
