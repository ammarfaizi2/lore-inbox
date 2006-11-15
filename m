Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030477AbWKOOSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbWKOOSH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 09:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbWKOOSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 09:18:07 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:18084 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1030477AbWKOOSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 09:18:05 -0500
Date: Wed, 15 Nov 2006 15:18:03 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Marty Leisner <leisner@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC  -- /proc/patches to track development
Message-ID: <20061115141803.GS23683@harddisk-recovery.com>
References: <200611150117.kAF1H3CD012244@dell2.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611150117.kAF1H3CD012244@dell2.home>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 08:17:03PM -0500, Marty Leisner wrote:
> I always want to know WHAT I'm running (or people I'm working with
> are running) rather than  "guessing" ("do you have the most current 
> patch" "I think so")
> 
> I've been a proponent of capturing .config information SOMEPLACE where
> you can look at it at runtime...(it took a while but its there now).
> 
> 
> In /proc/patches there would be a series of comments (perhaps including
> file, date and time) of various patches you want to monitor.  

[...]

> Seems very easy and has high ROI if you need to track patched kernels
> locally.

Even easier and doesn't need any kernel features or special comments:
use git to track your patches, enable CONFIG_LOCALVERSION_AUTO and
uname will tell you exactly what kernel you're running:

  erik@kostunrix:~ > uname -r
  2.6.18-gf6057327

To see what's different, just use git:

  git log --no-merges v2.6.18..f6057327 | git-shortlog

  Erik Mouw (1):
        2.6.18-rc6 config for kostunrix


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
