Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264242AbTFPU3I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 16:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbTFPU3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 16:29:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:13776 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264242AbTFPU3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 16:29:06 -0400
Date: Mon, 16 Jun 2003 13:38:41 -0700 (PDT)
Message-Id: <20030616.133841.35533284.davem@redhat.com>
To: janiceg@us.ibm.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, stekloff@us.ibm.com,
       girouard@us.ibm.com, lkessler@us.ibm.com, kenistonj@us.ibm.com,
       jgarzik@pobox.com
Subject: Re: patch for common networking error messages
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3EEE28DE.6040808@us.ibm.com>
References: <3EEE28DE.6040808@us.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Janice M Girouard <janiceg@us.ibm.com>
   Date: Mon, 16 Jun 2003 15:30:22 -0500

   EMSG_NET_LINK_UP     "%s: state change: link up, %d Mbps, %s-duplex\n"

Should indicate flow control state too.

   EMSG_NET_START_QUEUE "%s: performance event: (re)starting netdev queue\n"
   EMSG_NET_STOP_QUEUE  "%s: performance event: stopping netdev queue\n"

Oh _ABSOLUTELY NOT_, you're not printing a message
for normal events like this.  Especially those that are
going to occur on highly loaded systems.
