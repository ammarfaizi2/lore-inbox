Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbTLUHWm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 02:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTLUHWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 02:22:42 -0500
Received: from palrel11.hp.com ([156.153.255.246]:3030 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262291AbTLUHWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 02:22:40 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16357.19006.618784.521648@napali.hpl.hp.com>
Date: Sat, 20 Dec 2003 23:22:38 -0800
To: Greg KH <greg@kroah.com>
Cc: davidm@hpl.hp.com, ganesh@veritas.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: quick hack to make ipaq USB serial driver work again
In-Reply-To: <20031221010710.GB3025@kroah.com>
References: <200312200152.hBK1q0I4016741@napali.hpl.hp.com>
	<20031221010710.GB3025@kroah.com>
X-Mailer: VM 7.17 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 20 Dec 2003 17:07:10 -0800, Greg KH <greg@kroah.com> said:

  Greg> On Fri, Dec 19, 2003 at 05:52:00PM -0800, David Mosberger
  Greg> wrote:
  >> The ipaq USB driver in 2.6.0 didn't work for me.  I got the
  >> attached "Badness in local_bh_enable" backtrace when ppp tried to
  >> connect to my iPaq.  The quick and dirty patch to avoid the
  >> problem is this patch:

  Greg> See Paul's patch on lkml today for the ppp code to fix this in
  Greg> a "proper" way.  Or you can work on converting the usb-serial
  Greg> core to use a tasklet instead of directly feeding the data
  Greg> upstream at hard-interrupt time :)

Ah, so it's ppp's fault.  Glad I didn't spend more than 10 minutes on
this, given that Paul was already fixing it!

Thanks,

	--david
