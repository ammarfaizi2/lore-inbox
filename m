Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262697AbVCJCAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbVCJCAM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 21:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbVCJB7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:59:41 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:18440 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262622AbVCJBzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 20:55:45 -0500
Date: Thu, 10 Mar 2005 02:55:35 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Nick Stoughton <nick@usenix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: link(2) and symlinks
Message-ID: <20050310015535.GB4044@pclin040.win.tue.nl>
References: <1110410075.18359.384.camel@collie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110410075.18359.384.camel@collie>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 03:14:36PM -0800, Nick Stoughton wrote:
> On Linux, the link() system call does not dereference symbolic links
> 
> This behavior does not conform to POSIX
> 
> Most Unix implementations behave in the manner specified by POSIX.  One
> notable exception is Solaris 8 (I don't know about later Solarises). 
> 
> Would a patch to provide POSIX conforming behavior under some
> conditional case (e.g. if /proc/sys/posix has value 1) ever be accepted?

It sounds like a bad idea to have name resolution semantics dependent
upon some external variable. The result would be that nobody could be
sure anymore what the link() system call will do.

(Also, POSIX does not describe the kernel interface - it describes
a C interface. It would be possible for a libc to arrange that a
different link() routine was used.
Use of personality(2) does not sound like a good idea.)

((Maybe it would be beter to change POSIX here. Submit a defect report
and make the result of hard-linking to a symlink unspecified.
Since Linux and Solaris are non-POSIX here, programmers of portable
programs cannot rely on POSIX anyway. Moreover, the Linux/Solaris behaviour
sounds entirely reasonable, preferable in fact above the POSIX behaviour.))

Andries
