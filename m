Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131352AbRCPVx0>; Fri, 16 Mar 2001 16:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131413AbRCPVxQ>; Fri, 16 Mar 2001 16:53:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:39567 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131352AbRCPVw7>;
	Fri, 16 Mar 2001 16:52:59 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15026.35590.328863.956250@pizda.ninka.net>
Date: Fri, 16 Mar 2001 13:52:06 -0800 (PST)
To: "Mathieu Giguere (LMC)" <lmcmgig@lmc.ericsson.se>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Claude LeFrancois (LMC)" <lmcclef@lmc.ericsson.se>
Subject: RE: UDP stop transmitting packets!!!
In-Reply-To: <7E67DE81C0B6D311B30500805FFEBAAE03078E40@lmc35.lmc.ericsson.se>
In-Reply-To: <7E67DE81C0B6D311B30500805FFEBAAE03078E40@lmc35.lmc.ericsson.se>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mathieu Giguere (LMC) writes:
 > Thanks for your answer.
 > We will have a patch internally to handle this protection.

I would like to clarify my statements:

 > > -----Original Message-----
 > > From:	David S. Miller [SMTP:davem@redhat.com]
 > > Subject:	RE: UDP stop transmitting packets!!!
 > >
 > > If you kill the application, the queue is emptied and tossed
 > > by the kernel.

This should be "If you close the socket" then the queue will
be drained and free'd by the kernel.  Killing the application
is one way to get the socket closed.

Later,
David S. Miller
davem@redhat.com
