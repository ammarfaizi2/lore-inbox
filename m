Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267980AbTBMGwu>; Thu, 13 Feb 2003 01:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267981AbTBMGwu>; Thu, 13 Feb 2003 01:52:50 -0500
Received: from pizda.ninka.net ([216.101.162.242]:59543 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267980AbTBMGwu>;
	Thu, 13 Feb 2003 01:52:50 -0500
Date: Wed, 12 Feb 2003 22:48:06 -0800 (PST)
Message-Id: <20030212.224806.97357557.davem@redhat.com>
To: toml@us.ibm.com
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: IPSec: AH/ESP combination problems
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3E4AD852.4060300@us.ibm.com>
References: <3E4AD852.4060300@us.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tom Lendacky <toml@us.ibm.com>
   Date: Wed, 12 Feb 2003 17:27:14 -0600

   Again I'm not familiar enough with the code at this point
   to determine how to get the ESP protocol to be processed
   before the AH protocol in this case

You can enforce the ordering exactly when the xfrm templates
are built, this ensures that any fully resolved xfrm state
created from them have the correct ordering as well.
