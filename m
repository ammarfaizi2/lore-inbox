Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbTCYDNe>; Mon, 24 Mar 2003 22:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261432AbTCYDNa>; Mon, 24 Mar 2003 22:13:30 -0500
Received: from dp.samba.org ([66.70.73.150]:54753 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261413AbTCYDN1>;
	Mon, 24 Mar 2003 22:13:27 -0500
From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15999.52128.840507.233503@argo.ozlabs.ibm.com>
Date: Tue, 25 Mar 2003 14:23:12 +1100
To: "Cigol C" <linuxppp@indiainfo.com>
Cc: linux-serial@vger.kernel.org, linux-ppp@vger.kernel.org,
       redhat-ppp-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: RS485 communication
In-Reply-To: <20030324114308.30965.qmail@indiainfo.com>
References: <20030324114308.30965.qmail@indiainfo.com>
X-Mailer: VM 7.08 under Emacs 21.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cigol C writes:

> i) Linux PPP interface with IP: Registration, Packet send/receive/close
> ii) Linux PPP interface with serial driver:Registration, Packet send/receive/close

See Documentation/networking/ppp_generic.txt in any recent linux
kernel source tree.

> iii) Linux PPP server configuration and initial sequence of working. i.e. associating a IP address with serial device and ppp0

You will need a plugin for pppd that provides a new channel type.  See
the rp-pppoe plugin for an example of how this is done.

However, given that rs485 is multidrop, I really don't think PPP is
the best protocol to use.
