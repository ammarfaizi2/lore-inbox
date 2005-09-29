Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbVI2Gnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVI2Gnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 02:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbVI2Gnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 02:43:33 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:40242 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932098AbVI2Gnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 02:43:32 -0400
Date: Thu, 29 Sep 2005 08:43:28 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, bbpetkov@yahoo.de,
       linux-kernel@vger.kernel.org, R.E.Wolff@BitWizard.nl
Subject: Re: [PATCH] remove check_region in drivers-char-specialix.c
Message-ID: <20050929064328.GB25802@bitwizard.nl>
References: <20050928083737.GA29498@gollum.tnic> <20050928175244.GY7992@ftp.linux.org.uk> <20050928222822.GA14949@gollum.tnic> <20050929011026.GO7992@ftp.linux.org.uk> <20050928184106.49e9db11.akpm@osdl.org> <20050929020510.GR7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929020510.GR7992@ftp.linux.org.uk>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 03:05:10AM +0100, Al Viro wrote:
> On Wed, Sep 28, 2005 at 06:41:06PM -0700, Andrew Morton wrote:
>  
> > http://www.spinics.net/lists/kernel/msg399680.html
> 
> Ewww...  A lot of chunks consisting only of whitespace removals - great
> way to make patch less readable...
> 
> And yes, that second call of sx_request_io_range() must die.  BTW,
> what's wrong with use of mdelay() instead of that sx_long_delay()
> junk?  Replacing both calls of sx_long_delay() with mdelay(50) would do it...

Trust me: mdelay didn't exist when I wrote that.

The code calls the private function that does what I think should've
been kernel infrastructure all along to make it easy to either: 
change the body of the function to call the new infrastructure, or 
replace the call of the private function with the call to the new
infrastructure. 

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
