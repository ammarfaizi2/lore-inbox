Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269727AbUJGGxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269727AbUJGGxM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 02:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269728AbUJGGxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 02:53:12 -0400
Received: from relay.pair.com ([209.68.1.20]:18186 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S269727AbUJGGxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 02:53:07 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <4164DAC9.8080701@kegel.com>
Date: Wed, 06 Oct 2004 22:57:29 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
       bertrand marquis <bertrand.marquis@sysgo.com>
Subject: Building on case-insensitive systems and systems where -shared doesn't
 work well (was: Re: 2.6.8 link failure for sparc32 (vmlinux.lds.s: No such
 file or directory)?)
References: <414FC41B.7080102@kegel.com> <58517.194.237.142.24.1095763849.squirrel@194.237.142.24>
In-Reply-To: <58517.194.237.142.24.1095763849.squirrel@194.237.142.24>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Tue, Sep 21, 2004 at 10:40:24PM -0700, Dan Kegel wrote:
>>     683    2328   27265 linux-2.6.8-build_on_case_insensitive_fs-1.patch
>>      28     122    1028 linux-2.6.8-noshared-kconfig.patch
> 
> Can you please post these two patches.
> The fist I hope is very small today.

OK, here they are, plus a third one that also seems neccessary:

This one's by Martin Schaffner:
http://www.kegel.com/crosstool/crosstool-0.28-rc37/patches/linux-2.6.8/linux-2.6.8-build_on_case_insensitive_fs.patch

This one's by Kevin Hilman.  I haven't tried it yet, but seems neccessary:
http://www.kegel.com/crosstool/linux-2.6.8-netfilter-case-insensitive.patch

Both of the above choose arbitrary ways to avoid using
filenames identical but for case.  Feel free to pick
some other way, there's nothing magic about the names we picked.

This one's after an idea by bertrand.marquis@sysgo.com,
but it's small enough to be considered trivial.  Many OS's
don't support shared libraries as easily as Linux does,
and there's nothing to be gained by making libkconfig shared, so don't.
http://www.kegel.com/crosstool/crosstool-0.28-rc37/patches/linux-2.6.8/linux-2.6.8-noshared-kconfig.patch

Anything you can do to help get these patches
reviewed and possibly applied would be quite welcome.
- Dan

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
