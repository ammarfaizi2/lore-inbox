Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267872AbUIVFma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267872AbUIVFma (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 01:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267882AbUIVFma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 01:42:30 -0400
Received: from relay.pair.com ([209.68.1.20]:9225 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S267872AbUIVFm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 01:42:28 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <41511048.9000603@kegel.com>
Date: Tue, 21 Sep 2004 22:40:24 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8 link failure for sparc32 (vmlinux.lds.s: No such file or
 directory)?
References: <414FC41B.7080102@kegel.com> <58517.194.237.142.24.1095763849.squirrel@194.237.142.24> <20040921105745.GJ9106@holomorphy.com>
In-Reply-To: <20040921105745.GJ9106@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>>Look like arch/sparc/boot/Makefile is too old.
>>vmlinux.lds.s were renamed to vmlinux.lds 2004/08/15 - maybe you need to
>>checkout that file?
> 
> I don't see this kind of issue in current 2.6.x; what's going on?

Figured it out.  It was user error.  I had an outdated patch.
Sorry for the noise.  Next time I'll check my patches more carefully.
- Dan

p.s. For what it's worth, I only need to apply five patches to
vanilla 2.6.8 to get past various build errors:
      60     258    2483 kaz-types.patch
      50     207    2088 linux-2.6.8-arm-nonofpu.patch
     683    2328   27265 linux-2.6.8-build_on_case_insensitive_fs-1.patch
     285    1215   10145 linux-2.6.8-m68k-kludge.patch
      28     122    1028 linux-2.6.8-noshared-kconfig.patch
The build_on_case_insensitive_fs patch is the one that was out of date.

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
