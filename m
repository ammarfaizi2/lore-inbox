Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267205AbUHOWrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267205AbUHOWrO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 18:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267209AbUHOWrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 18:47:14 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:37255 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S267205AbUHOWrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 18:47:10 -0400
Date: Mon, 16 Aug 2004 00:47:05 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@fs.tum.de>
cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: menuconfig displays dependencies [Was: select FW_LOADER ->
 depends HOTPLUG]
In-Reply-To: <20040815174028.GM1387@fs.tum.de>
Message-ID: <Pine.LNX.4.61.0408160043270.12687@scrub.home>
References: <20040809195656.GX26174@fs.tum.de> <20040809203840.GB19748@mars.ravnborg.org>
 <Pine.LNX.4.58.0408100130470.20634@scrub.home> <20040810084411.GI26174@fs.tum.de>
 <20040810211656.GA7221@mars.ravnborg.org> <Pine.LNX.4.58.0408120027330.20634@scrub.home>
 <20040814074953.GA20123@mars.ravnborg.org> <20040814210523.GG1387@fs.tum.de>
 <Pine.LNX.4.61.0408151932370.12687@scrub.home> <20040815174028.GM1387@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 15 Aug 2004, Adrian Bunk wrote:

> And what's the correct handling of dependencies the selected symbol has?
> 
> FW_LOADER depends on HOTPLUG, and this was the issue that started the 
> whole thread.

The use of select is already a crotch here, so there's no real correct 
handling. There are a few possibilities:
- if you select FW_LOADER, you have to select HOTPLUG too
- if you select FW_LOADER, you have to depend on HOTPLUG
- FW_LOADER itself can select HOTPLUG

bye, Roman
