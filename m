Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbUKQVyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbUKQVyx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 16:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbUKQVs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 16:48:56 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:30101 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262668AbUKQVsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 16:48:38 -0500
Date: Wed, 17 Nov 2004 13:48:24 -0800
From: Greg KH <greg@kroah.com>
To: Colin Leroy <colin@colino.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotplug_path no longer exported
Message-ID: <20041117214824.GA1291@kroah.com>
References: <20041117203139.7c9f5e95.colin@colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117203139.7c9f5e95.colin@colino.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 08:31:39PM +0100, Colin Leroy wrote:
> Hi,
> 
> hotplug_path is no longer exported, is this on purpose ?

Yes.

> It breaks linux-wlan-ng. If it is on purpose, I suppose linux-wlan-ng
> should use kobject_hotplug() ?

Yes it should.  Why was it not useing that function in the first place?

> If not, here's a patch.

No, please use kobject_hotplug().  Actually, what are they doing that
they need to call kobject_hotplug() in the first place?

thanks,

greg k-h
