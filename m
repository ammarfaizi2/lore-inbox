Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWGFXZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWGFXZB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWGFXZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:25:01 -0400
Received: from relay02.pair.com ([209.68.5.16]:45831 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751038AbWGFXZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:25:00 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
To: Greg KH <gregkh@suse.de>
Subject: Re: Linux 2.6.17.4
Date: Thu, 6 Jul 2006 18:24:23 -0500
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
References: <20060706222704.GB2946@kroah.com> <20060706222841.GD2946@kroah.com>
In-Reply-To: <20060706222841.GD2946@kroah.com>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607061824.46990.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 July 2006 17:28, Greg KH wrote:
>  		case PR_SET_DUMPABLE:
> -			if (arg2 < 0 || arg2 > 2) {
> +			if (arg2 < 0 || arg2 > 1) {
>  				error = -EINVAL;
>  				break;
>  			}

Am I staring at this crooked, or not looking deep enough? My manual page for 
prctl says 2 is valid there. Specifically:

              Since  kernel 2.6.13, the value 2 is also permitted; this causes
              any binary which normally would not be dumped to be dumped read-
              able   by   root   only.    (See   also   the   description   of
              /proc/sys/fs/suid_dumpable in proc(5).)

...has something changed, and my manpages don't reflect it? Did I miss a 
conversation about this?

Thanks,
Chase
