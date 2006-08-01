Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751802AbWHATHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbWHATHa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWHATHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:07:30 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:5090 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751802AbWHATH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:07:29 -0400
Date: Tue, 1 Aug 2006 21:06:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 1/33] i386: vmlinux.lds.S Distinguish absolute symbols
Message-ID: <20060801190657.GA12573@mars.ravnborg.org>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <11544302283864-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11544302283864-git-send-email-ebiederm@xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 05:03:16AM -0600, Eric W. Biederman wrote:
> Ld knows about 2 kinds of symbols,  absolute and section
> relative.  Section relative symbols symbols change value
> when a section is moved and absolute symbols do not.
> 
> Currently in the linker script we have several labels
> marking the beginning and ending of sections that
> are outside of sections, making them absolute symbols.
> Having a mixture of absolute and section relative
> symbols refereing to the same data is currently harmless
> but it is confusing.
In the past we have seen problems when there was some padding between
the global symbol and the actual section start. The reason for the
padding was the alignment of the section which is aligned accordign to
the longest of the contained symbols. So no matter the
relocatable kernel this is an improvement.

	Sam
