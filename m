Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268215AbUHQNDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268215AbUHQNDh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 09:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268218AbUHQNDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 09:03:36 -0400
Received: from elektroni.ee.tut.fi ([130.230.131.11]:10646 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S268215AbUHQNDb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 09:03:31 -0400
Date: Tue, 17 Aug 2004 16:03:29 +0300
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>, alan@lxorguk.ukuu.org.uk,
       jwendel10@comcast.net, linux-kernel@vger.kernel.org,
       Kai.Makisara@kolumbus.fi
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
Message-ID: <20040817130329.GA7800@elektroni.ee.tut.fi>
Mail-Followup-To: Marc Ballarin <Ballarin.Marc@gmx.de>,
	Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>,
	alan@lxorguk.ukuu.org.uk, jwendel10@comcast.net,
	linux-kernel@vger.kernel.org, Kai.Makisara@kolumbus.fi
References: <411FD919.9030702@comcast.net> <20040816143817.0de30197.Ballarin.Marc@gmx.de> <1092661385.20528.25.camel@localhost.localdomain> <20040816231211.76360eaa.Ballarin.Marc@gmx.de> <4121A689.8030708@bio.ifi.lmu.de> <20040817134133.56614674.Ballarin.Marc@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817134133.56614674.Ballarin.Marc@gmx.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 01:41:33PM +0200, Marc Ballarin wrote:
> An unpatched cdrecord does not use root privileges to access devices. It
> increases its priority, locks memory and drops privileges before doing
> anything else. According to its author, cdrecord is designed for this mode
> of operation. I don't know if the same is true for growisofs and other
> tools.
> suid has no effect on the issue at hand (provided cdrecord has not
> been modified), it only serves to increase burning reliability.

I guess you are talking about some alpha version. The latest released
unpatched stable version cdrecord 2.00.3 burns ok as suid-root even with
this kind of device access rights:

brw-------  1 root root 22, 0 Jun  9  2002 /dev/hdc
