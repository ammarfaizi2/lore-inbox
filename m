Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVCPAwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVCPAwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 19:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbVCPAwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 19:52:19 -0500
Received: from palrel13.hp.com ([156.153.255.238]:26786 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262200AbVCPAwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 19:52:16 -0500
Message-ID: <4237833E.9080809@hp.com>
Date: Tue, 15 Mar 2005 16:52:14 -0800
From: Rick Jones <rick.jones2@hp.com>
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.6) Gecko/20040304
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, ctindel@users.sourceforge.net,
       fubar@us.ibm.com, bonding-devel@lists.sourceforge.net,
       netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: [patch 2.6.11] bonding: avoid tx balance for IGMP (alb/tlb mode)
References: <20050315215128.GA18262@tuxdriver.com>
In-Reply-To: <20050315215128.GA18262@tuxdriver.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is that switch behaviour "normal" or "correct?"  I know next to nothing about 
what stuff like LACP should do, but asked some internal folks and they had this 
to say:

<excerpt>


<blank> treats IGMP packets the same as all other non-broadcast traffic (i.e. it
will attempt to load balance). This switch behavior seems rather odd in an
aggregated case, given the fact that most traffic (except broadcast packets)
will be load balanced by the partner device. In addition, the switch (in
theory) is suppose to treat the aggregated switch ports as 1 logical port
and therefore it should allow IGMP packets to be received back on any port
in the logical aggregation.

IMO, the switch behavior in this case seems questionable.

</excerpt>

FWIW,

rick jones
