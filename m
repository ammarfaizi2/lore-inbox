Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264040AbTDNWdW (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264046AbTDNWdW (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:33:22 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:17887 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264040AbTDNWdV (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 18:33:21 -0400
Date: Mon, 14 Apr 2003 15:46:07 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC] /sbin/hotplug multiplexor - take 2
Message-ID: <20030414224607.GC6411@kroah.com>
References: <20030414190032.GA4459@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030414190032.GA4459@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, based on the comments so far, how about this proposed version of
/sbin/hotplug to provide a multiplexor?

thanks,

greg k-h

----------
#!/bin/sh
DIR="/etc/hotplug.d"

for I in "${DIR}/$1/"* "${DIR}/"all/* ; do
	test -x $I && $I $1 ;
done

exit 1
----------

