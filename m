Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265811AbUFOSeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265811AbUFOSeO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265815AbUFOSeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:34:14 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:14354 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265811AbUFOSeJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:34:09 -0400
Date: Tue, 15 Jun 2004 20:37:00 +0200
To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AT Keyboard (was: Helge Hafting vs. make menuconfig help)
Message-ID: <20040615183700.GA13866@hh.idb.hist.no>
References: <20040615140206.A6153@beton.cybernet.src> <20040615141039.GF20632@lug-owl.de> <20040615142040.B6241@beton.cybernet.src> <20040615144127.GG20632@lug-owl.de> <20040615172129.F6843@beton.cybernet.src> <20040615173210.GM20632@lug-owl.de> <20040615174651.A6965@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040615174651.A6965@beton.cybernet.src>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 05:46:51PM +0000, Karel Kulhavý wrote:
> > In 2.4.x, the transition from "old-style" input drivers to new-style
> > (Input API) was never finished. Instead, Input API was introduced, and
> > HID devices reported their input to Input API, while old drivers still
> > used all their old ways to deliver their input.
> 
> I (hopefully correctly) assume that one of the old ones is AT keyboard.
> 
> What happens when I press a key on keyboard and the application that
> has the keyboard somehow on it's stdin reads a key? What happens between
> the two events and how does it travel inside the kernel?
> 
> I know how the keys can be read from port 0x60 or whichever.
> 
1. You press the key (on an AT keyboard)
2. The keyboard hardware makes an interrupt
3. The interrupt acitvates the i8042 driver (in 2.6)
   which does the port 0x60 stuff.  
4. From there, the key is propagated through tty and
   console and ends up in your application.  This application
   might be X, which passes the key onto some program using X.

Helge Hafting
 
