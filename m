Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTIFTik (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 15:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTIFTik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 15:38:40 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55289 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261168AbTIFTij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 15:38:39 -0400
Date: Sat, 6 Sep 2003 21:38:30 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Gordon Stanton <coder101@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] must fix generic_serial .c
Message-ID: <20030906193830.GD14436@fs.tum.de>
References: <20030901062643.14448.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901062643.14448.qmail@linuxmail.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 02:26:43PM +0800, Gordon Stanton wrote:

> Hi,

Hi Gordon,

>   While trying to get most drivers in the kernel to compile, I had to skip a lot of the older ones that use cli() and sti() since deep knowledge is needed to fix those. Because of this I am asking that someone would please fix generic_serial.c in drivers/char and document in a HOWTO on the steps they took and the reasons behind it. This would help more people to be able to understand and fix a lot of the other drivers with the cli/sti problem. Even if the it wasn't generic_serial.c but one of the other serial drivers with the same problem, it still would be very instructive and help other to improve the kernel quicker. 

it's a known problem that generic_serial doesn't compile in SMP kernels 
due to cli/sti problems.

Documentation/cli-sti-removal.txt already documents how to fix such 
drivers (although it's usually non-trivial).

> Gordon

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

