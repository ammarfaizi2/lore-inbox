Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282186AbRK1Wtx>; Wed, 28 Nov 2001 17:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280940AbRK1Wtn>; Wed, 28 Nov 2001 17:49:43 -0500
Received: from pizda.ninka.net ([216.101.162.242]:26521 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282115AbRK1Wtb> convert rfc822-to-8bit;
	Wed, 28 Nov 2001 17:49:31 -0500
Date: Wed, 28 Nov 2001 14:49:25 -0800 (PST)
Message-Id: <20011128.144925.94842859.davem@redhat.com>
To: groudier@free.fr
Cc: matthias@winterdrache.de, linux-kernel@vger.kernel.org
Subject: Re: sym53c875: reading /proc causes SCSI parity error
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011128203718.L2777-100000@gerard>
In-Reply-To: <20011128.131503.22504634.davem@redhat.com>
	<20011128203718.L2777-100000@gerard>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gérard Roudier <groudier@free.fr>
   Date: Wed, 28 Nov 2001 20:51:01 +0100 (CET)
   
   On Wed, 28 Nov 2001, David S. Miller wrote:
   
   > Why not just put some bitmap pointer into the pci device
   > struct.  If it is non-NULL, it specifies PCI config space
   > areas which have side-effects.
   
   Or a simple offset beyond which reading data isn't desirable for
   whatever reasons.

I do not think that is sufficient.

I have seen chips where only one single PCI config space word would
trigger problems, and it was due to a hw bug.  The "offset beyond"
scheme would not allow to cover this case.
