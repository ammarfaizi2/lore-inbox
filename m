Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSFVW2p>; Sat, 22 Jun 2002 18:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316916AbSFVW2p>; Sat, 22 Jun 2002 18:28:45 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:34834 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316883AbSFVW2o>; Sat, 22 Jun 2002 18:28:44 -0400
Date: Sun, 23 Jun 2002 00:28:38 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: CML2
In-Reply-To: <20020622215453.A13719@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0206222259430.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 22 Jun 2002, Sam Ravnborg wrote:

> Despite the fact that you are advancing slowly could you explain what your plans
> are with the configuration system?
>
> As of today we have basically three different ways to read the Config.in files,
> where xconfig are the one with the best but also most critical parser/analyser.
> Do you plan to replace all of them or?

My plan is to convert the current configuration into a new format (I have
a tool for that), which is more flexible and will allow that all needed
information to configure/build a driver is at a single place. It currently
looks like this:

config BLK_DEV_SD
  depends SCSI
  tristate "SCSI disk support"
  help
  If you want to use a SCSI hard disk ...

More information can be added later to this.

The current parsers will all be replaced with a single parser, actually
it's a library that does all the work and which allows multiple front
ends to behave identical.

bye, Roman


