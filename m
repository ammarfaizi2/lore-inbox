Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbTKCQtM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 11:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbTKCQtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 11:49:12 -0500
Received: from palrel11.hp.com ([156.153.255.246]:26816 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262101AbTKCQtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 11:49:10 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16294.34563.711608.728876@napali.hpl.hp.com>
Date: Mon, 3 Nov 2003 08:49:07 -0800
To: trelane@digitasaru.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: IA64/x86-64 and execution protection support?
In-Reply-To: <20031103144932.GC31953@digitasaru.net>
References: <20031103144932.GC31953@digitasaru.net>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 3 Nov 2003 08:49:33 -0600, Joseph Pingenot <trelane@digitasaru.net> said:

  Joseph> Hello.  I was reading El Reg this morning when they
  Joseph> discussed "execution protection" on the new Intel (IA64) and
  Joseph> AMD (K8 and above) chips.  Does the Linux kernel have
  Joseph> support for preventing execution of certain memory regions
  Joseph> on those architectures?

Yes, on ia64, data and stack do not get mapped executable by default.
Also, return addresses (under the discretion of the compiler) are
virtually always stored on a separate register stack, making it more
difficult to use memory stack overflows to overwrite return addresses.

	--daviid
