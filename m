Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbVBEBSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbVBEBSq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 20:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263004AbVBEBLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 20:11:16 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:7955 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266478AbVBEBI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 20:08:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=kOSFQXlrPmd4V7PLCjvVHwp2AiTUZyldkAok3/XrkeJgG1vyMTiPgWhjdl1JtPpcQHr8Hb61C0xIUUuealsYIdk2ES5dnUvl9rFU6AB1k4EAwIjF8s+Ad3bz1wkRbRYYXWwFTltNnpaL9wx9v+EvqbZfvM4IlNucdq4p8WBwQ24=
Message-ID: <9e47339105020417081d5a82e4@mail.gmail.com>
Date: Fri, 4 Feb 2005 20:08:57 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Subject: Re: [RFC] Reliable video POSTing on resume
Cc: Pavel Machek <pavel@ucw.cz>, ncunningham@linuxmail.org,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <420418C7.5010309@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050122134205.GA9354@wsc-gmbh.de> <4202A972.1070003@gmx.net>
	 <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams>
	 <4202DF7B.2000506@gmx.net>
	 <1107485504.5727.35.camel@desktop.cunninghams>
	 <9e4733910502032318460f2c0c@mail.gmail.com>
	 <20050204074454.GB1086@elf.ucw.cz>
	 <9e473391050204093837bc50d3@mail.gmail.com> <420418C7.5010309@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Feb 2005 01:52:23 +0100, Carl-Daniel Hailfinger
<c-d.hailfinger.devel.2005@gmx.net> wrote:
> My problem (Samsung P35) is that the BIOS wants to call code which
> is no longer mapped because the BIOS is too big to fit into the
> standard area. Since that additional area has been overwritten, we
> are out of luck. Maybe if we did something like backing up all

Look at the scitech source code. There are a limited number of system
BIOS calls that need to be implemented. It is a fairly small number.
wakeup.S could supply implementations for these and patch them into
the right interrupt vectors while the VBIOS is being run. There is no
requirement that VBIOS run the actual system BIOS, it only has to
think that it is running on the system BIOS. This is the same scheme
used for running the ROMs in user space.

-- 
Jon Smirl
jonsmirl@gmail.com
