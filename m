Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266169AbUINVyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUINVyA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 17:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269675AbUINVvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 17:51:03 -0400
Received: from attila.bofh.it ([213.92.8.2]:28099 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S266687AbUINVqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 17:46:06 -0400
Date: Tue, 14 Sep 2004 23:45:52 +0200
From: "Marco d'Itri" <md@Linux.IT>
To: Greg KH <greg@kroah.com>
Cc: "Giacomo A. Catenazzi" <cate@pixelized.ch>, linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-ID: <20040914214552.GA13879@wonderland.linux.it>
References: <41473972.8010104@debian.org> <41474926.8050808@nortelnetworks.com> <20040914195221.GA21691@kroah.com> <414757FD.5050209@pixelized.ch> <20040914213506.GA22637@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914213506.GA22637@kroah.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 14, Greg KH <greg@kroah.com> wrote:

> What's wrong with the /etc/dev.d/ location for any type of script that
> you want to run after a device node has appeared?  This is an
> application specific issue, not a kernel issue.
The problem is that since most distributions cannot make udev usage
mandatory, this would require duplicating in the init script and in the
dev.d script whatever needs to be done with the device.
Then there are the issues of scripts needing programs in /usr, which may
not be mounted when the module is loaded, or which are interactive and
need console access (think fsck).
Basically asyncronous creation of devices requires a ground up redesign
of the init scripts of a distribution. I'm not claiming that this is not
possible, but it's not going to happen soon.

-- 
ciao, |
Marco | [8002 aveHSeIFcnkpI]
