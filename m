Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310143AbSCPHw1>; Sat, 16 Mar 2002 02:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310145AbSCPHwQ>; Sat, 16 Mar 2002 02:52:16 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:59151 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S310143AbSCPHwD>;
	Sat, 16 Mar 2002 02:52:03 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH] devexit fixes in i82092.c 
In-Reply-To: Your message of "Fri, 15 Mar 2002 23:40:30 -0800."
             <Pine.LNX.4.33.0203152339200.31551-100000@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Mar 2002 18:51:51 +1100
Message-ID: <15271.1016265111@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2002 23:40:30 -0800 (PST), 
Linus Torvalds <torvalds@transmeta.com> wrote:
>On Fri, 15 Mar 2002, Jeff Garzik wrote:
>> Further, I wonder if the reboot/shutdown notifiers can be replaced with 
>> device tree control over those events...
>
>This is what I want. Those reboot/shutdown notifiers are completely and 
>utterly buggy, and cannot sanely handle any kind of device hierarchy.

Does that mean that we also get rid of the initcall methods?  If
shutdown follows a device tree then startup should also use that tree.
OTOH module load and unload require well defined startup and shutdown
functions, modules cannot rely on device trees.

