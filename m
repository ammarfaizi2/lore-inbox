Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVAGAE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVAGAE2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263133AbVAFX7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:59:31 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:62406 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263094AbVAFX4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:56:36 -0500
Date: Thu, 6 Jan 2005 15:56:34 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, paulmck@us.ibm.com,
       arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] add feature-removal-schedule.txt documentation
Message-ID: <20050106235633.GA10110@kroah.com>
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106152621.395f935e.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 03:26:21PM -0800, Andrew Morton wrote:
> Which begs the question "how do we ever get rid of these things when we
> have no projected date for Linux-2.8"?
> 
> I'd propose:
> 
> a) Create Documentation/feature-removal-schedule.txt which describes
>    things which are going away, when, why, who is involved, etc.

Ok, I'll bite, here's a patch that does just that.  Look good?

thanks,

greg k-h

-----------

Add Documentation/feature-removal-schedule.txt as a way to notify
everyone when and what is going to be removed.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/feature-removal-schedule.txt	2005-01-06 15:54:40 -08:00
@@ -0,0 +1,17 @@
+The following is a list of files and features that are going to be
+removed in the kernel source tree.  Every entry should contain what
+exactly is going away, why it is happening, and who is going to be doing
+the work.  When the feature is removed from the kernel, it should also
+be removed from this file.
+
+---------------------------
+
+What:	devfs
+When:	July 2005
+Files:	fs/devfs/*, include/linux/devfs_fs*.h and assorted devfs
+	function calls throughout the kernel tree
+Why:	It has been unmaintained for a number of years, has unfixable
+	races, contains a naming policy within the kernel that is
+	against the LSB, and can be replaced by using udev.
+Who:	Greg Kroah-Hartman <greg@kroah.com>
+
