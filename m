Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262369AbSJ0LqD>; Sun, 27 Oct 2002 06:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262370AbSJ0LqC>; Sun, 27 Oct 2002 06:46:02 -0500
Received: from ns.suse.de ([213.95.15.193]:12813 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262369AbSJ0LqB>;
	Sun, 27 Oct 2002 06:46:01 -0500
Date: Sun, 27 Oct 2002 12:52:18 +0100
From: Dave Jones <davej@suse.de>
To: Peter L Jones <peter@drealm.org.uk>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: Linux 2.5.44-ac4
Message-ID: <20021027125218.A21310@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Peter L Jones <peter@drealm.org.uk>, linux-kernel@vger.kernel.org,
	alan@redhat.com
References: <200210270925.07460@advent.drealm.org.uk> <200210271040.31765@advent.drealm.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210271040.31765@advent.drealm.org.uk>; from peter@drealm.org.uk on Sun, Oct 27, 2002 at 11:40:31AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc:'d back to l-k where this belongs]

On Sun, Oct 27, 2002 at 11:40:31AM +0100, Peter L Jones wrote:
 > The mce.c entries are excluded by "#ifdef CONFIG_X86_MCE".  For some reason, 
 > the entire subdirectory has been built but the processor-specific modules 
 > don't have any CONFIG_X86_MCE protection.  This one's beyond my skill even to 
 > attempt to fix.  I guess I'll turn on machine check exceptions...

Oops, it's broken if CONFIG_X86_MCE=n
Change arch/i386/kernel/cpu/Makefile line 16 to read
obj-$(CONFIG_X86_MCE)   +=  mcheck/
and it should be ok..

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
