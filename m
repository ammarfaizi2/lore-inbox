Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUGLU11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUGLU11 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 16:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbUGLUYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 16:24:24 -0400
Received: from palrel10.hp.com ([156.153.255.245]:51919 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262547AbUGLUVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 16:21:35 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16626.62155.711114.734967@napali.hpl.hp.com>
Date: Mon, 12 Jul 2004 13:21:31 -0700
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>, Jakub Jelinek <jakub@redhat.com>,
       davidm@hpl.hp.com, suresh.b.siddha@intel.com, jun.nakajima@intel.com,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: serious performance regression due to NX patch
In-Reply-To: <Pine.LNX.4.58.0407121315170.1764@ppc970.osdl.org>
References: <200407100528.i6A5SF8h020094@napali.hpl.hp.com>
	<Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407110550340.4229@devserv.devel.redhat.com>
	<20040711123803.GD21264@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407121402160.2451@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407121315170.1764@ppc970.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 12 Jul 2004 13:17:20 -0700 (PDT), Linus Torvalds <torvalds@osdl.org> said:

  Linus> On Mon, 12 Jul 2004, Ingo Molnar wrote:
  >>  so ... this should be #ifndef ia64?

  Linus> No. Make it a CONFIG_DEFAULT_NOEXEC and make the relevant
  Linus> architectures do a

  Linus> 	define_bool DEFAULT_NOEXEC y

  Linus> in their Kconfig files.

Would it be better to reverse the sense (i.e., make it DEFAULT_EXEC),
since the latter new platforms by default almost certainly do NOT want
DEFAULT_EXEC?

	--david
