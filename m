Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbVIRBFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVIRBFf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 21:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVIRBFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 21:05:35 -0400
Received: from khc.piap.pl ([195.187.100.11]:6660 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751295AbVIRBFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 21:05:34 -0400
To: jesper.juhl@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why don't we separate menuconfig from the kernel?
References: <m364szk426.fsf@defiant.localdomain>
	<9a874849050917174635768d04@mail.gmail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 18 Sep 2005 03:05:32 +0200
In-Reply-To: <9a874849050917174635768d04@mail.gmail.com>
Message-ID: <m3d5n7kwwz.fsf@defiant.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> writes:

> What exactely is it you want to make a sepperate package?

Just the menuconfig (mconf) at first. OTOH it might make sense to
move them all.

> menuconfig is just a little bit of the kbuild system which also
> includes xconfig, config, gconfig, oldconfig, etc.  menuconfig is just
> a dialog based frontend to the kbuild system which consists of
> configuration options, help texts, dependency info etc.

Sure, that's what I mean. It's used for configuring the kernel, but
other packages use it (well, some version) too. Example: busybox.

There is no much point in keeping more than one copy. They are
completely independent of the kernel, all the kernel wants is to pass
them some Kconfig file and expect data in .config. (oldconfig uses
.config.old).

There is a question about config language and possible future changes.
Not a serious problem IMHO.

> I don't think it makes much sense to split the parts of kbuild that
> make up menuconfig out into a standalone thing. kbuild (and thus
> menuconfig) has little use outside the kernel.

It's not exactly the case.
-- 
Krzysztof Halasa
