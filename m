Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316988AbSGCJUU>; Wed, 3 Jul 2002 05:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316989AbSGCJUT>; Wed, 3 Jul 2002 05:20:19 -0400
Received: from pc-62-30-72-191-ed.blueyonder.co.uk ([62.30.72.191]:45952 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S316988AbSGCJUT>; Wed, 3 Jul 2002 05:20:19 -0400
Date: Wed, 3 Jul 2002 10:22:44 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: khromy <khromy@lnuxlab.ath.cx>
Cc: linux-kernel@vger.kernel.org, ext3-users@redhat.com,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: sync slowness. ext3 on VIA vt82c686b
Message-ID: <20020703102244.B2491@redhat.com>
References: <20020703022051.GA2669@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020703022051.GA2669@lnuxlab.ath.cx>; from khromy@lnuxlab.ath.cx on Tue, Jul 02, 2002 at 10:20:51PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 02, 2002 at 10:20:51PM -0400, khromy wrote:
> When I copy a file(13Megs) from /home/ to /tmp/, sync takes almost 2 minutes. 
> When I copy the same file to /usr/local/, sync returns almost right away.  Both 
> filesystems are ext3 and are on the same harddrive.  When sync is running, 
> the harddrive light stays on but I don't hear it doing anything. dmesg doesn't 
> show any errors either. Below is the `time` output for each command.  If you 
> need anymore information  let me know..

Ugh.  My first guess would be that you have one enormously fragmented
filesystem.  13MB in 2 minutes?  A modern disk should get that amount
of data to disk in one second, but massive fragmentation can simply
kill disk performance.

If /home is on the same disk, do you get the same problem trying to
write there?

--Stephen
