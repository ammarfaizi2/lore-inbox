Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWAYAWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWAYAWw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 19:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWAYAWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 19:22:52 -0500
Received: from [81.2.110.250] ([81.2.110.250]:60397 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750880AbWAYAWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 19:22:51 -0500
Subject: Re: pppd oopses current linu's git tree on disconnect
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <43D6BBCF.7090403@microgate.com>
References: <20060119010601.f259bb32.diegocg@gmail.com>
	 <1137692039.3279.1.camel@amdx2.microgate.com>
	 <20060119230746.ea78fcf4.diegocg@gmail.com> <43D01537.40705@microgate.com>
	 <20060123034243.22ba0a8f.diegocg@gmail.com>
	 <20060124044846.de6508eb.diegocg@gmail.com>
	 <1138140391.3223.15.camel@amdx2.microgate.com>
	 <1138145129.21284.12.camel@localhost.localdomain>
	 <43D6BBCF.7090403@microgate.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 25 Jan 2006 00:22:53 +0000
Message-Id: <1138148573.21723.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-24 at 17:44 -0600, Paul Fulghum wrote:
> But if space == 0 then tty->buf.tail could be NULL
> Touching tb could oops. I think you already do a similar
> check in tty_insert_flip_string() etc.

Might be worth using unlikely() hints there. I'd not considered the NULL
case.

