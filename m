Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWANLEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWANLEM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 06:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbWANLEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 06:04:12 -0500
Received: from soundwarez.org ([217.160.171.123]:51437 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751232AbWANLEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 06:04:10 -0500
Date: Sat, 14 Jan 2006 12:04:01 +0100
From: Kay Sievers <kay.sievers@suse.de>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: Greg K-H <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] INPUT: add MODALIAS to the event environment
Message-ID: <20060114110401.GA11237@vrfy.org>
References: <11371818082670@kroah.com> <11371818084013@kroah.com> <43C88898.10900@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C88898.10900@ums.usu.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 10:14:00AM +0500, Alexander E. Patrakov wrote:
> Greg KH wrote:
> >[PATCH] INPUT: add MODALIAS to the event environment
> >
> >input: add MODALIAS to the event environment
> 
> Could you please tell me sample modaliases for a number of "common" 
> devices (like a PS/2 mouse)?
> 
> I ask because earlier (namely, in 
> http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/old/gregkh-all-2.6.15.patch) 
> such modaliases contained commas (",") and comma is not a "trusted" 
> character in Udev (see replace_untrusted_chars() in udev_utils_string.c). 
> Thus, such modaliases were mangled and didn't work.

Only if you read it with $sysfs{modalias}, it's available in $env{MODALIAS}
and does not get mangled there, right? If you have problems with that,
let us know and we will fix it.

(We can't trust the values of some sysfs files to be passed to external
programs or directly used to create a device node name, cause some of
them are directly copied from a device property.)

Thanks,
Kay
