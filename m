Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264991AbSJWNgU>; Wed, 23 Oct 2002 09:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbSJWNgU>; Wed, 23 Oct 2002 09:36:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42501 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264991AbSJWNgR>;
	Wed, 23 Oct 2002 09:36:17 -0400
Date: Wed, 23 Oct 2002 14:42:27 +0100
From: Matthew Wilcox <willy@debian.org>
To: "Vamsi Krishna S ." <vamsi@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: kernel hooks interface available to non-GPL modules?
Message-ID: <20021023144227.O27461@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


+EXPORT_SYMBOL(hook_exit_deregister);
+EXPORT_SYMBOL(hook_exit_arm);
+EXPORT_SYMBOL(hook_exit_disarm);
+EXPORT_SYMBOL(_hook_initialise);
+EXPORT_SYMBOL(_hook_terminate);
+EXPORT_SYMBOL(_hook_exit_register);

I'm not sure this is a great idea.  OK, your DECLARE_HOOK macros are _GPL
(and why are they _NOVERS_GPL?  Surely this is the exact kind of thing
you want versioned?), but I wouldn't have to use the DECLARE_HOOK macros,
would I?

If you thought the LSM GPL furore was bad, this one would be worse.

-- 
Revolutions do not require corporate support.
