Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264244AbTDPGK0 (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 02:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264245AbTDPGK0 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 02:10:26 -0400
Received: from office.mandrakesoft.com ([195.68.114.34]:47353 "EHLO
	mandrakesoft.com") by vger.kernel.org with ESMTP id S264244AbTDPGKZ 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 02:10:25 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] /sbin/hotplug multiplexor - take 2
References: <20030414190032.GA4459@kroah.com>
	<20030414224607.GC6411@kroah.com>
From: Frederic Lepied <flepied@mandrakesoft.com>
Date: 16 Apr 2003 08:22:13 +0200
In-Reply-To: <20030414224607.GC6411@kroah.com>
Message-ID: <m3ptnnezca.fsf@skywalker.mandrakesoft.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> Ok, based on the comments so far, how about this proposed version of
> /sbin/hotplug to provide a multiplexor?

I think it would be good to launch only the files ending by a special
extension to avoid running backup files. Something like that:

#!/bin/sh
DIR="/etc/hotplug.d"

for I in "${DIR}/$1/"*.hotplug "${DIR}/"all/*.hotplug ; do
	test -x $I && $I $1 ;
done
-- 
Fred - May the source be with you
