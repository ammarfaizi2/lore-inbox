Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUFZWtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUFZWtz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 18:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267216AbUFZWtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 18:49:55 -0400
Received: from mail-relay-4.tiscali.it ([212.123.84.94]:35206 "EHLO
	sparkfist.tiscali.it") by vger.kernel.org with ESMTP
	id S266879AbUFZWto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 18:49:44 -0400
Date: Sun, 27 Jun 2004 00:49:42 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org, mmokrejs@natur.cuni.cz
Subject: Re: radeonfb: cannot map FB
Message-ID: <20040626224942.GA13345@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.OSF.4.51.0406262358120.7750@tao.natur.cuni.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin MOKREJ¦ <mmokrejs@natur.cuni.cz> ha scritto:
> Hi,
>  could someone help with radeonfb not detected under 2.4.27-rc2?
> I filed this bug under the 2.6 bugzilla ... :(
> http://bugzilla.kernel.org/show_bug.cgi?id=2917
> Thanks
> Please Cc: me in replies.

ioremap is failing. You likely have 1GB (or more) of RAM and kernel is
unable to find some space in lowmem to map the video RAM (128MB).

In 2.6 this is fixed by mapping only a small amount of video RAM (at
most 16MB).

Backport should be easy, I'll cook a patch ASAP.

Luca
-- 
Home: http://kronoz.cjb.net
Let me make your mind, leave yourself behind
Be not afraid
