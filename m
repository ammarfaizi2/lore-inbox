Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbTFQSzO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 14:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264900AbTFQSzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 14:55:14 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:44720 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264898AbTFQSzK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 14:55:10 -0400
Message-ID: <3EEF66AA.3000509@us.ibm.com>
Date: Tue, 17 Jun 2003 14:06:18 -0500
From: Janice M Girouard <janiceg@us.ibm.com>
Organization: IBM Linux Technology Center - Network Device Drivers
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: "David S. Miller" <davem@redhat.com>, shemminger@osdl.org,
       Valdis.Kletnieks@vt.edu, Janice Girouard <girouard@us.ibm.com>,
       Daniel Stekloff <stekloff@us.ibm.com>,
       Larry Kessler <lkessler@us.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: patch for common networking error messages
References: <OFCA1A4F38.D782F1D3-ON85256D48.000A5CED@us.ibm.com>	<200306170434.h5H4YZPZ003025@turing-police.cc.vt.edu>	<20030617090859.0ffa0ca8.shemminger@osdl.org> <20030617.090930.102574393.davem@redhat.com> <3EEF620A.40608@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Jeff Gazik <jgarzik@pobox.com>
    Date: Tue, 17 Jun 2003 01:46

    ...and it's been in the tree for quite a while too.  It's a shame
    people aren't taking advantage of it's obvious utility...


I'd like to hear what others believe belong in this new netlink family. 
 The two events that come to mind for this family (or netdev notified if 
that's more appropriate) are:
1) device initialization failures,
2) events that drive load balancing software.  Right now if we need to 
throttle the card, we don't send events up to indicate we have reached 
capacity.  

Possibly the first might belong in the netdev notified family, and the 
second in the netlink family, since you might want to present more than 
a two state (success/failure.. or just failure in this case) result.
-




