Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268794AbUILTDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268794AbUILTDs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 15:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268799AbUILTDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 15:03:47 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:58594 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268794AbUILTDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 15:03:43 -0400
Subject: Re: [PATCH] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, joq@io.com, torbenh@gmx.de
In-Reply-To: <Xine.LNX.4.44.0409120956150.16684-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0409120956150.16684-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1095015830.1306.640.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 12 Sep 2004 15:03:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-12 at 09:58, James Morris wrote:
> On Sun, 12 Sep 2004, Lee Revell wrote:
> 
> > +config SECURITY_REALTIME
> > +	tristate "Realtime Capabilities"
> > +	depends on SECURITY && SECURITY_CAPABILITIES!=y
> > +	default n
> > +	help
> > +	  Answer M to build realtime support as a Linux Security
> > +	  Module.  Answering Y to build realtime capabilities into the
> > +	  kernel makes no sense.
> 
> Why not just make it a bool then?
> 

Good idea.

> I wonder if it might be better to specify configuration via 
> /proc/<pid>/attr rather than module parameters.
> 

This would not work for several reasons.  How would you decide who is
allowed to run RT processes?  Root would have to set the above value,
which defeats the purpose of the realtime-lsm module which is to
selectively allow non-root users to run RT tasks.

Here is a good summary of the security issues that have been raised:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=269661

Realtime-lsm solves all of these problems.

Lee

