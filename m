Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWDGPnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWDGPnd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 11:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWDGPnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 11:43:33 -0400
Received: from xenotime.net ([66.160.160.81]:62179 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964807AbWDGPnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 11:43:33 -0400
Date: Fri, 7 Apr 2006 08:45:48 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [RFC/POC] multiple CONFIG y/m/n
Message-Id: <20060407084548.f676f2a6.rdunlap@xenotime.net>
In-Reply-To: <87odzdh1fp.fsf@duaron.myhome.or.jp>
References: <20060406224134.0430e827.rdunlap@xenotime.net>
	<87odzdh1fp.fsf@duaron.myhome.or.jp>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Apr 2006 00:04:26 +0900 OGAWA Hirofumi wrote:

> "Randy.Dunlap" <rdunlap@xenotime.net> writes:
> 
> > As it is here, PARPORT_ENABLE_ALL tracks PARPORT (y/m/n) when the former
> > is enabled/configured.  The downside of this Kconfig usage is that almost
> > all lines of "depends" are duplicated as "select" (and that it uses "select").
> > It would be good if there was some way to automate this.
> >
> > Comments?
> 
> Umm... Oh, how about the following?  It seems work...
> 
>	$ perl -spi -e 's/CONFIG_SND.*//' .config
>	$ KCONFIG_ALLCONFIG=.config make allmodconfig or allyesconfig

Yes, that seems to do what I want to do.

Very nice, thanks.

---
~Randy
