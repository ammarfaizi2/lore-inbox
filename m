Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945972AbWJaUUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945972AbWJaUUx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 15:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945974AbWJaUUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 15:20:53 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:47507 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1945972AbWJaUUx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 15:20:53 -0500
Message-ID: <4547B01A.2060700@drzeus.cx>
Date: Tue, 31 Oct 2006 21:20:42 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>
CC: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
       Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>, Dominik Brodowski <linux@brodo.de>,
       Harald Welte <laforge@netfilter.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: feature-removal-schedule obsoletes
References: <45324658.1000203@gmail.com> <20061016133352.GA23391@lst.de> <200610242124.49911.arnd@arndb.de> <4543162B.7030701@drzeus.cx> <20061031155756.GA23021@wohnheim.fh-wedel.de>
In-Reply-To: <20061031155756.GA23021@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> Why does the MMC block driver use a thread?  Is there a technical
> reason for this or could it be done in original process context as
> well, removing some code and useless cpu scheduler overhead?
>   

I'm afraid I don't know the block layer very well, but that thread seems
to be polling the block layer for requests and handing the over to the
routines in mmc_block.c.

How do you set it up so that the block layer itself calls the necessary
function?

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

