Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbTETUD6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 16:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbTETUD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 16:03:58 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:41924 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261179AbTETUD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 16:03:57 -0400
Date: Tue, 20 May 2003 16:16:49 -0400
To: David Balazic <david.balazic@uni-mb.si>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Wrong clock initialization
Message-ID: <20030520201649.GA18678@delft.aura.cs.cmu.edu>
Mail-Followup-To: David Balazic <david.balazic@uni-mb.si>,
	linux-kernel@vger.kernel.org
References: <3ECA673F.7B3FB388@uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ECA673F.7B3FB388@uni-mb.si>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 07:34:55PM +0200, David Balazic wrote:
> As almost nobody runs their clock in UTC, this means that the system
> is running on wrong time until some userspace tool corrects it.

I thought everybody used the CMOS clock in UTC, which means that the
kernel doesn't have to know anything about nasty little details related
to timezones, daylight savings time and such. Localtime is just a
presentation issue.

> This can lead to situtation when time goes backwards :
> 
> timezone is 2hours east of UTC.
> UTC time : 20:00
> local time : 22:00
> 
> System time between boot and userspace fix : 22:00UTC
> System time after fix : 20:00UTC
> 
> Comments ?

All your disks are typically still mounted readonly and no important
applications are running except for perhaps an fsck /dev/root between
the time the system is booted and the clock is fixed up. So it really
doesn't matter whether your clock is off by a couple of hours for a
couple of seconds (a minute?) during boot.

Jan

