Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269708AbRHIGwF>; Thu, 9 Aug 2001 02:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269707AbRHIGvz>; Thu, 9 Aug 2001 02:51:55 -0400
Received: from imladris.infradead.org ([194.205.184.45]:4619 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S269709AbRHIGvm>;
	Thu, 9 Aug 2001 02:51:42 -0400
Date: Thu, 9 Aug 2001 07:51:33 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Sarada prasanna <csaradap@mihy.mot.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Automated tasks
In-Reply-To: <C1590740235CD211BA5600A0C9E1F6FF0260226B@hydmail.mihy.mot.com>
Message-ID: <Pine.LNX.4.33.0108090739590.10432-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sarada.

 > I have a process here before which I have to complete some pre
 > required tasks ...Right now I do them manually.....i want an
 > automated process that will do them automatically....

 > Is there any way.....

 > Will makefile or shell file come to my rescue....

A shell script would sort this out for you, but without details of the
tasks, I couldn't write one for you.

Basically, your shell script looks like this:

 1. The following line at the top of the script:

	#!/bin/bash

 2. The commands to be run, one per line, in the order they are to be
    run.

So, for example, if I need to...

 1. Change to the temporaries directory.

	cd /tmp

 2. Remove anything therein with 'AntiVirus' at the start of its name
    (as a security measure):

	rm -f AntiVirus*

 3. Run a virus scanner called `AntiVirus`:

	AntiVirus

...I would set up the following batch file:

	#!/bin/bash
	cd /tmp
	rm -f AntiVirus*
	AntiVirus

It's literally as simple as that.

Best wishes from Riley.

