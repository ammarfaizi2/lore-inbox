Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbTJJUQI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 16:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTJJUQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 16:16:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:17078 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261437AbTJJUQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 16:16:06 -0400
Date: Fri, 10 Oct 2003 13:15:38 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Michael Hunold (LinuxTV.org CVS maintainer) <hunold@linuxtv.org>,
       "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/14] LinuxTV.org DVB driver update
Message-Id: <20031010131538.74b78a14.shemminger@osdl.org>
In-Reply-To: <10656197274033@convergence.de>
References: <10656197274033@convergence.de>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.5claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This update broke the dvb network device changes to make it work with the
new rules about dynamic allocation for 2.6.  It reverts the code to getting
the network device out of an array, so it will break if:
	rmmod dvb_net </sys/class/net/dvb0_0/mtu

See:
	Documentation/net/netdevices.txt
