Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264268AbTDJXqB (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 19:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbTDJXqA (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 19:46:00 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:27140 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S264264AbTDJXp6 (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 19:45:58 -0400
Date: Fri, 11 Apr 2003 01:57:30 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org, <linux-scsi@vger.kernel.org>,
       <pbadari@us.ibm.com>
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain
 backward compatibility
In-Reply-To: <UTC200304102209.h3AM9pf11795.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0304110154590.12110-100000@serv>
References: <UTC200304102209.h3AM9pf11795.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 11 Apr 2003 Andries.Brouwer@cwi.nl wrote:

> The conclusion is that the easy way out is to define MAX_NR_DISKS.
> A different way out, especially when we use 32+32, is to kill this
> sd_index_bits[] array, and give each disk a new number: replace
> 	index = find_first_zero_bit(sd_index_bits, SD_DISKS);
> by
> 	index = next_index++;

This one is fun:
http://www.ussg.iu.edu/hypermail/linux/kernel/0103.3/0394.html

Anyway, unless you fix all programs which scan /dev/sg*, you better keep 
the used range dense, so this not really option.

bye, Roman

