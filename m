Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268136AbUHKSMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268136AbUHKSMf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 14:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268142AbUHKSMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 14:12:35 -0400
Received: from palrel10.hp.com ([156.153.255.245]:36814 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S268136AbUHKSMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 14:12:15 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16666.24955.224034.291755@napali.hpl.hp.com>
Date: Wed, 11 Aug 2004 11:12:11 -0700
To: Chris Wright <chrisw@osdl.org>
Cc: davidm@hpl.hp.com, James Morris <jmorris@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kurt Garloff <garloff@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
In-Reply-To: <20040811082510.D1924@build.pdx.osdl.net>
References: <20040810131217.Q1924@build.pdx.osdl.net>
	<Xine.LNX.4.44.0408101630250.9412-100000@dhcp83-76.boston.redhat.com>
	<16665.56613.143598.768389@napali.hpl.hp.com>
	<20040811082510.D1924@build.pdx.osdl.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 11 Aug 2004 08:25:10 -0700, Chris Wright <chrisw@osdl.org> said:

  >> An alternative solution might be to have a call_likely() macro,
  >> where you could predict the most likely target of an indirect
  >> call.  Perhaps that could help other platforms as well.

  Chris> Hmm, the pointers are generally quite static, set once near
  Chris> boot time typically, and that's it.  Seems like a plausible
  Chris> win.  Do you have an example of what call_likely() would look
  Chris> like?

The macro I had in mind works only for static (compile-time)
predictions, I'm afraid.

	--david
