Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbTDEPqW (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 10:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbTDEPqW (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 10:46:22 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10760 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262502AbTDEPqV (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 10:46:21 -0500
Date: Sat, 5 Apr 2003 16:57:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: Makefile bug
Message-ID: <20030405165751.A22180@flint.arm.linux.org.uk>
Mail-Followup-To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
References: <UTC200304051408.h35E8wl20163.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200304051408.h35E8wl20163.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Sat, Apr 05, 2003 at 04:08:58PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 04:08:58PM +0200, Andries.Brouwer@cwi.nl wrote:
> A moment ago I again encountered the infamous
> 	Error inserting 'module.o': -1 Invalid module format
> 
> What is wrong this time? Hmm.
> 	version magic '2.5.65' should be '2.5.66'
> 
> Aha. So the command "make modules" given in a tree that used
> to be 2.5.65 and was patched up to 2.5.66 fails to rebuild
> modules.
> 
> The dependency goes
> 	foo.mod.c includes <linux/vermagic.h>
> 	<linux/vermagic.h> includes <linux/version.h>
> 
> (this happens for all modules, so is a generic makefile bug).

Kai has a fix which he's tested.  I have it in my tree ready for the next
kernel release to confirm that this problem has gone.  Maybe Kai will
post it to lkml...

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

