Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264749AbVBDRrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264749AbVBDRrY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVBDRka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:40:30 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:54574 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266391AbVBDRiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:38:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=aeLhhc27RWyPQbT1ivdI2tSBysSSAc6VGxPuVN4uZEZWubSqbFV7jWqYJGa82NmtUIO5+wGNgqqTCu0Z4qio2LT4y9uFAUsvAwYpU08sCICVFg93VEDE9PNikw33MQ8h/zQ7bZpGGw3P17yOvxj5aO/gk+8BN2OYHyrClXYrvo0=
Message-ID: <9e473391050204093837bc50d3@mail.gmail.com>
Date: Fri, 4 Feb 2005 12:38:21 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI] Samsung P35, S3, black screen (radeon))
Cc: ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050204074454.GB1086@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050122134205.GA9354@wsc-gmbh.de>
	 <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net>
	 <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams>
	 <4202DF7B.2000506@gmx.net>
	 <1107485504.5727.35.camel@desktop.cunninghams>
	 <9e4733910502032318460f2c0c@mail.gmail.com>
	 <20050204074454.GB1086@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005 08:44:54 +0100, Pavel Machek <pavel@ucw.cz> wrote:
> We already try to do that, but it hangs on 70% of machines. See
> Documentation/power/video.txt.

We know that all of these ROMs are run at power on so they have to
work. This implies that there must be something wrong with the
environment the ROM are being run in. Video ROMs make calls into the
INT vectors of the system BIOS. If these haven't been set up yet
running the VBIOS is sure to hang.  Has someone with ROM source and
the appropriate debugging tools tried to debug one of these hangs?
Alternatively code could be added to wakeup.S to try and set these up
or dump the ones that are there and see if they are sane.

-- 
Jon Smirl
jonsmirl@gmail.com
