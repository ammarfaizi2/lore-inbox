Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265175AbUEZEus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265175AbUEZEus (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 00:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265165AbUEZEus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 00:50:48 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:56262 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265176AbUEZEuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 00:50:46 -0400
Message-ID: <40B41367.5070607@kegel.com>
Date: Tue, 25 May 2004 20:47:51 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: bringing back 'make symlinks'?
References: <40B36A0E.5080509@kegel.com> <20040525214328.GA2675@mars.ravnborg.org>
In-Reply-To: <20040525214328.GA2675@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Tue, May 25, 2004 at 08:45:18AM -0700, Dan Kegel wrote:
> 
>>In the 2.4 kernel, 'make symlinks' created the symlinks needed
>>to use the kernel tree's headers for building a gcc/glibc toolchain.
>>
>>In the 2.6 kernel, you can do the same thing with 'include include/asm'.
>>Unless you're trying to build arm or cris, or maybe others, in which case 
>>you also need 'include/asm-$(ARCH)/.arch'.
> ...
> 
> In current 2.6 there exitst a target named: modules_prepare
> It does a bit more than what symlinks did in 2.4 - actually prepare for
> building external modules.

Right, and that's a problem, because the 'bit more' it does
requires a target compiler -- which isn't available while
bootstrapping the target compiler!

The way things are now, I can build toolchains for everything
except the sh architecture (though my toolchain bootstrap script
is ugly as noted due to the lack of 'make symlinks').
I'm not sure if the sh architecture makefile even has targets
to make all the needed symlinks in the absense of a working
target compiler; I'll look at that and maybe submit a minimal
patch when I get a chance.
- Dan

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
