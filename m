Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSDKPK0>; Thu, 11 Apr 2002 11:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314084AbSDKPKZ>; Thu, 11 Apr 2002 11:10:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:2518 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314083AbSDKPKY>;
	Thu, 11 Apr 2002 11:10:24 -0400
Date: Thu, 11 Apr 2002 08:01:35 -0700 (PDT)
Message-Id: <20020411.080135.92719326.davem@redhat.com>
To: abraham@2d3d.co.za
Cc: linux-kernel@vger.kernel.org
Subject: Re: CHECKSUM_HW not behaving as expected
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020411170458.A2786@crystal.2d3d.co.za>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rubini's book is wrong, CHECKSUM_HW means the chip computed the pseudo
checksum of the packet and this computed value is in skb->csum

You want to set CHECKSUM_UNNECESSARY, see include/linux/skbuff.h which
documents all of these variables.
