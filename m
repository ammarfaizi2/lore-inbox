Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267153AbTCEPBR>; Wed, 5 Mar 2003 10:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267159AbTCEPBR>; Wed, 5 Mar 2003 10:01:17 -0500
Received: from pizda.ninka.net ([216.101.162.242]:58041 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267153AbTCEPBQ>;
	Wed, 5 Mar 2003 10:01:16 -0500
Date: Wed, 05 Mar 2003 06:53:41 -0800 (PST)
Message-Id: <20030305.065341.35361286.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: wa@almesberger.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] make atm (and clip) modular + try_module_get() 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200303051508.h25F8gGi006299@locutus.cmf.nrl.navy.mil>
References: <20030305.063158.53514369.davem@redhat.com>
	<200303051508.h25F8gGi006299@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Wed, 05 Mar 2003 10:08:42 -0500

   In message <20030305.063158.53514369.davem@redhat.com>,"David S. Miller" writes
   :
   >If you own both objects, why lock anything?
   
   i believe the original intent was to prevent anyone else from 
   appending to either of the lists while the lists are being joined.
   while it would be slightly less efficient, should it use the
   skb primitives?  this is quite a bit easier to read:

I understand why you think you have to lock, that isn't the issue.

I'm telling you that you should be locking this crap at a much
higher level.
