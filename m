Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTJUCcD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 22:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbTJUCcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 22:32:03 -0400
Received: from www.paclaw.org ([149.175.1.5]:46298 "HELO lewis.lclark.edu")
	by vger.kernel.org with SMTP id S262601AbTJUCcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 22:32:01 -0400
Subject: DRM and pci_driver conversion
From: Eric Anholt <eta@lclark.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sf.net
Content-Type: text/plain
Message-Id: <1066703516.646.24.camel@leguin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 20 Oct 2003 19:31:56 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently committed a change to the DRM for Linux in DRI CVS that
converted it to use pci_driver and that probe system.  Unfortunately,
we've found that there is a conflict between the DRM now and at least
the radeon framebuffer.  Both want to attach to the same device, and
with pci_driver, the second one to come along doesn't get probe called
for that device.  Is there any way to mark things shared, or in some
other way get the DRM to attach to a device that's already attached to,
in the new model?

Please CC me on replies as I'm not subscribed to these lists.

-- 
Eric Anholt                                eta@lclark.edu          
http://people.freebsd.org/~anholt/         anholt@FreeBSD.org


