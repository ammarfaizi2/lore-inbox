Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267312AbUIANqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267312AbUIANqa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267250AbUIANqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:46:25 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:11531 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S266568AbUIANnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:43:08 -0400
Date: Wed, 1 Sep 2004 15:43:00 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040901134300.GA85587@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <courier.41359B53.00007549@softhome.net> <20040901095229.GA11908@devserv.devel.redhat.com> <courier.4135A19B.00007EA5@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <courier.4135A19B.00007EA5@softhome.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 04:16:59AM -0600, filia@softhome.net wrote:
> I do not see much point in renaming ioctl() to write() all over the place - 
> at least when people see ioctl() they understand that it is not standard 
> functionality. write() will for sure confuse a lot of people. 

Because you can encapsulate write while you can't encapsulate ioctl
for a start.  And because ascii is good and opaque binary is bad.  You
don't change the target position of your motion device millions of
time per second.  You can easily send your commands and replies
(you're allowed read, too) as text, and immediatly you make logging,
debugging and reproducing actions way easier.  Plus API portability to
64bits/other endian is free.

  OG.
