Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270995AbTHBHEZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 03:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271025AbTHBHEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 03:04:25 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:10515 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S270995AbTHBHEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 03:04:24 -0400
Date: Sat, 2 Aug 2003 09:04:22 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Bernd Porr <Bernd.Porr@cn.stir.ac.uk>
Cc: linux-kernel@vger.kernel.org, comedi@comedi.org
Subject: Re: compiling external kernel modules (comedi.org)
Message-ID: <20030802070422.GA2404@mars.ravnborg.org>
Mail-Followup-To: Bernd Porr <Bernd.Porr@cn.stir.ac.uk>,
	linux-kernel@vger.kernel.org, comedi@comedi.org
References: <3F2B0E06.9000907@cn.stir.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2B0E06.9000907@cn.stir.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 02:04:06AM +0100, Bernd Porr wrote:
> Hi all,
> 
> I'm trying to compile comedi on 2.6-test2. The very naive way (with 
> configure) does not work (as expected). However, comedi conforms 
> (mainly) to the kernel makefile convention. So I tried this:
> 
> make -C /usr/src/linux-2.6.0-test2 
> SUBDIRS=/home/bp1/c/usb/2.6/comedi/comedi/ V=1

When compiling modules use:
make -C /usr/src/linux-2.6.0-test2 SUBDIRS=$PWD V=1 modules
See the added "modules" target.

	Sam
