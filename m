Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274434AbRJEXLG>; Fri, 5 Oct 2001 19:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274424AbRJEXK5>; Fri, 5 Oct 2001 19:10:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12424 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274434AbRJEXKu>;
	Fri, 5 Oct 2001 19:10:50 -0400
Date: Fri, 05 Oct 2001 16:11:05 -0700 (PDT)
Message-Id: <20011005.161105.78709492.davem@redhat.com>
To: cwidmer@iiic.ethz.ch
Cc: linux-kernel@vger.kernel.org
Subject: Re: unnecessary retransmit from network stack
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200110051229.f95CTvN00624@mail.swissonline.ch>
In-Reply-To: <200110051229.f95CTvN00624@mail.swissonline.ch>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christian Widmer <cwidmer@iiic.ethz.ch>
   Date: Fri, 5 Oct 2001 14:29:53 +0200

   why does net_dev.hard_start_xmit get called multiple times 
   with the same tcp packet?  
   
Because the ACK is not coming back for those packets within the RTO
(which for a local network is very low).  Check your TCP dumps,
the ACKs of the original data packets are being dropped in transit.

Franks a lot,
David S. Miller
davem@redhat.com
