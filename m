Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316755AbSGBMWN>; Tue, 2 Jul 2002 08:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316756AbSGBMWN>; Tue, 2 Jul 2002 08:22:13 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:26356 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S316755AbSGBMWM>; Tue, 2 Jul 2002 08:22:12 -0400
Message-ID: <3D219A52.1060008@quark.didntduck.org>
Date: Tue, 02 Jul 2002 08:19:30 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timo Benk <t_benk@web.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: allocate memory in userspace
References: <20020701172659.GA4431@toshiba>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timo Benk wrote:
> Hi,
> 
> I am a kernel newbie and i am writing a module. I 
> need to allocate some memory in userspace because
> i want to access syscalls like open(), lstat() etc.
> I need to call these methods in the kernel, and in
> my special case there is no other way, but i 
> do not want to reimplement all the syscalls.

What are you trying to do with this module?  If you are needing to use 
syscalls like open(), you are probably trying to do something that is 
forbidden in kernel space.  For example, trying to read a configuration 
file.

Recommended reading:
http://www.linux.org.uk/~ajh/ols2002_proceedings.pdf.gz
The chapter named "How NOT to write kernel drivers", especially sections 
7 and 8.

--
				Brian Gerst

