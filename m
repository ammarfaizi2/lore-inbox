Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWCPVBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWCPVBm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 16:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWCPVBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 16:01:42 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:33956
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751297AbWCPVBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 16:01:41 -0500
From: Rob Landley <rob@landley.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Mounting /dev/loop0: Device or resource busy
Date: Thu, 16 Mar 2006 16:01:59 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <200603141508.53504.rob@landley.net> <Pine.LNX.4.61.0603162122160.11776@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0603162122160.11776@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603161601.59364.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 March 2006 3:23 pm, Jan Engelhardt wrote:
> >Why can I mount most block devices multiple times, but when I try to mount
> > a loop device more than once under 2.6.16-rc5 it tells me it's busy?
>
> It should be possible to mount a block device multiple times using the
> _same_ filesystem.

It turns out it complains if the flags are different.  The first mount was 
with no flags, the second was -o ro.  (I thought the kernel had been upgraded 
so that would work.  My bad.)

Rob
-- 
Never bet against the cheap plastic solution.
