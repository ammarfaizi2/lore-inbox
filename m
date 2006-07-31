Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbWGaTFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbWGaTFd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWGaTFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:05:33 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:391 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030329AbWGaTFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:05:32 -0400
Message-ID: <44CE5473.8080903@pobox.com>
Date: Mon, 31 Jul 2006 15:05:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, "J.A. Magall?n" <jamagallon@ono.com>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.18-rc2-mm1] libata ate one PATA channel
References: <20060728134550.030a0eb8@werewolf.auna.net>	 <44CD0E55.4020206@gmail.com> <20060731172452.76a1b6bd@werewolf.auna.net>	 <44CE2908.8080502@gmail.com>	 <1154363489.7230.61.camel@localhost.localdomain>	 <20060731165011.GA6659@htj.dyndns.org>  <44CE37CF.1010804@gmail.com> <1154371972.7230.95.camel@localhost.localdomain> <44CE515B.1060302@gmail.com>
In-Reply-To: <44CE515B.1060302@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> I like 'registering both always and disabling one' approach for 
> partially stolen legacy devices.  We can make ->hard_port_no do the job 
> as before, but IMHO it's error-prone and only useful for very limited 
> cases (first legacy port stolen).
> 
> Jeff, what do you think?


The reason for hard_port_no's existence is the fact that is can 
sometimes differ from port_no, and we need to know the "real" port 
number, as opposed to the port number based on counting probed ports.

If you eliminate the need for hard_port_no, feel free to erase it.

	Jeff


