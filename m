Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266296AbTBCWLi>; Mon, 3 Feb 2003 17:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbTBCWLi>; Mon, 3 Feb 2003 17:11:38 -0500
Received: from chaos.analogic.com ([204.178.40.224]:60056 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266296AbTBCWLh>; Mon, 3 Feb 2003 17:11:37 -0500
Date: Mon, 3 Feb 2003 17:23:57 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Daniel Heater <daniel.heater@gefanuc.com>
cc: Dhruv Gami <dhruvgami@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: module programming blues
In-Reply-To: <20030203215700.GA205@gefhsvrootwitch>
Message-ID: <Pine.LNX.3.95.1030203171841.7386B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Feb 2003, Daniel Heater wrote:

> * Dhruv Gami (dhruvgami@yahoo.com) wrote:
> > Hello Everyone,
> > 
> > I am trying to develop a kernel module that will read
> > some user input (being given to a file) and perform
> > certain flag settings based on the information dumped
> > in the file.
> 

Easy. You have a user-program open the device and send it
parameters via ioctl(). That's the way it's supposed to be
done in a Unix environment. Devices get their parameters via
ioctls.

I have modules that get the entire contents of ASICs from
the contents of user-mode files. Something, at some time,
needs to `insmod` the module anyway. The exact same procedure
that does that can run a program that configures the module
dynamicaly, based, not only on the contents of files, but also
anything else. Do not make hacks to read files from the kernel.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


