Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264827AbTFQPzi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 11:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264828AbTFQPzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 11:55:38 -0400
Received: from air-2.osdl.org ([65.172.181.6]:23732 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264827AbTFQPzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 11:55:36 -0400
Date: Tue, 17 Jun 2003 09:08:59 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: girouard@us.ibm.com, davem@redhat.com, stekloff@us.ibm.com,
       janiceg@us.ibm.com, jgarzik@pobox.com, lkessler@us.ibm.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: patch for common networking error messages
Message-Id: <20030617090859.0ffa0ca8.shemminger@osdl.org>
In-Reply-To: <200306170434.h5H4YZPZ003025@turing-police.cc.vt.edu>
References: <OFCA1A4F38.D782F1D3-ON85256D48.000A5CED@us.ibm.com>
	<200306170434.h5H4YZPZ003025@turing-police.cc.vt.edu>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Binary interface's will never cut it.  Read the hotplug thread to see how Linus
said, he will never add a binary event daemon interface.

That said, there is an oppurtunity for to provide a ascii interface (similar to
/sbin/hotplug) decodes the data from the rtnetlink interface in a standardized format.

Then it would be easy to write things like perl monitoring scripts that do things
like:
	perl phone-me-if-network-dies.pl < /proc/net/events

Don't flame me about the choce of name. /proc/net/events is not the right name 
to use for such an interface since adding more to /proc is probably not desired.

