Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264038AbTKDJzr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 04:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264040AbTKDJzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 04:55:47 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:26124 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264038AbTKDJzp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 04:55:45 -0500
Message-ID: <3FA779F5.6090704@aitel.hist.no>
Date: Tue, 04 Nov 2003 11:05:41 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: no, en
MIME-Version: 1.0
To: Tomas Szepe <szepe@pinerecords.com>
CC: Valdis.Kletnieks@vt.edu, lkml <linux-kernel@vger.kernel.org>
Subject: Re: how to restart userland?
References: <20031103193940.GA16820@louise.pinerecords.com> <200311032003.hA3K3tgv017273@turing-police.cc.vt.edu> <20031103201223.GC16820@louise.pinerecords.com>
In-Reply-To: <20031103201223.GC16820@louise.pinerecords.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe wrote:

> 
>>Is there a reason you want to "completely" restart userland and *not*
>>reboot (for instance, wanting to keep existing mounts, etc)?
> 
> 
> Extensive userland upgrades (glibc is a nice example I guess), etc.
> 
Consider using debian then - a glibc upgrade there
is no problem as various services (including init)
are restarted automatically mostly without disturbing
running applications.

To make everything use the new library revision,
do an "init 1".  You'll get to single-user mode where
you either log in and do an "init 2" or simply
press ctrl+D for the same effect.

After that, nothing is holding onto deleted old libraries
and /usr may be remounted read-only if you like.

Helge Hafting

