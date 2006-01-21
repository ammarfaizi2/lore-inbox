Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWAUXPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWAUXPv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 18:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWAUXPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 18:15:51 -0500
Received: from cantor2.suse.de ([195.135.220.15]:5263 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751221AbWAUXPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 18:15:50 -0500
Date: Sun, 22 Jan 2006 00:15:39 +0100
From: Olaf Hering <olh@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cc-version not available to change EXTRA_CFLAGS
Message-ID: <20060121231539.GA23789@suse.de>
References: <20060121180805.GA15761@suse.de> <20060121225728.GA13756@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060121225728.GA13756@mars.ravnborg.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Jan 21, Sam Ravnborg wrote:

> Let me know if this works for you.

Works perfect, beside this minor glitch.

Warning: trailing whitespace in line 1067 of
Documentation/kbuild/makefiles.txt

> >  ifeq ($(CONFIG_PPC32),y)
> > -EXTRA_CFLAGS := -O1
> > +EXTRA_CFLAGS := $(shell set -x ; if [ $(call cc-version) -lt 0402 ] ; then echo $(call cc-option,-O1); fi ;)
> 
> For -O1 I do not see the point in using $(call cc-option ...).
> I assume all gcc version does support -O1 - or?

this was just c&p during debug, from another file.

> +	Example:
> +		#fs/reiserfs/Makefile
> +		EXTRA_CFLAGS := $(call cc-ifversion, -lt, 0402, -O1)
> +
> +	In this example EXTRA_CFLAGS will be assigned the value -O1 if the
> +	$(CC) version is less than 4.2.

I meant 4.0.2 as shipped with SuSE 10.0, but thats ok. I think the buggy
version was 3.2, as we have not seen in with gcc 3.3-hammer in SLES9.
Will you include the reiserfs change with a check for earlier then 4.0
or 4.1 or should I send a separate patch?

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
