Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVASQKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVASQKf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 11:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVASQKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 11:10:35 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:31386 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261766AbVASQKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 11:10:31 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: kbuild: Implicit dependence on the C compiler
To: Sam Ravnborg <sam@ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Reply-To: 7eggert@gmx.de
Date: Wed, 19 Jan 2005 17:09:03 +0100
References: <fa.e2phu9o.1c30pig@ifi.uio.no> <fa.gakt9b5.1klcr9h@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1CrIPb-0000lS-Oz@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> wrote:

> 1) Unconditionally execute make install assuming vmlinux is up-to-date.
>    make modules_install run unconditionally, so this is already know
>    practice

(o) Vote for this.

IMO, a make install should NEVER run the compiler.

The reason is: I'm deliberaely compiling as a user on the fastest system
before I copy or mount the FS to/on some other box and do a make install.
The other box will be _very_ slow while compiling or missing some of the
needed components (e.g. gcc).

