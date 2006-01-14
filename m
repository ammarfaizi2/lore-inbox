Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWANNVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWANNVs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 08:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWANNVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 08:21:48 -0500
Received: from soundwarez.org ([217.160.171.123]:62855 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751244AbWANNVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 08:21:48 -0500
Date: Sat, 14 Jan 2006 14:21:38 +0100
From: Kay Sievers <kay.sievers@suse.de>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: Greg K-H <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] INPUT: add MODALIAS to the event environment
Message-ID: <20060114132138.GA12273@vrfy.org>
References: <11371818082670@kroah.com> <11371818084013@kroah.com> <43C88898.10900@ums.usu.ru> <20060114110401.GA11237@vrfy.org> <43C8F962.9030409@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C8F962.9030409@ums.usu.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 06:15:14PM +0500, Alexander E. Patrakov wrote:
> Kay Sievers wrote:
> >On Sat, Jan 14, 2006 at 10:14:00AM +0500, Alexander E. Patrakov wrote:
> >>Greg KH wrote:
> >>
> >>>[PATCH] INPUT: add MODALIAS to the event environment
> >>>
> >>>input: add MODALIAS to the event environment
> >>>
> >>Could you please tell me sample modaliases for a number of "common" 
> >>devices (like a PS/2 mouse)?
> >>
> >>I ask because earlier (namely, in 
> >>http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/old/gregkh-all-2.6.15.patch) 
> >>such modaliases contained commas (",") and comma is not a "trusted" 
> >>character in Udev (see replace_untrusted_chars() in udev_utils_string.c). 
> >>Thus, such modaliases were mangled and didn't work.
> >
> >Only if you read it with $sysfs{modalias}, it's available in $env{MODALIAS}
> >and does not get mangled there, right? If you have problems with that,
> >let us know and we will fix it.
> > 
> >
> With the old gregkh-all-2.6.15.patch, I have:
> 
> sh-3.1# cat /sys/class/input/input1/modalias
> input:b0011v0002p0004e0000-e0,1,2,k110,111,112,113,114,r0,1,8,amlsfw

> i.e., there is the "modalias" file in sysfs but no $MODALIAS in the 
> environment. Is this the problem that your patch solves (note: I haven't 
> tried it yet)?

Well, you could have read the mail's subject, before posting.

Kay
