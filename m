Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291104AbSBGElE>; Wed, 6 Feb 2002 23:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291105AbSBGEky>; Wed, 6 Feb 2002 23:40:54 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17046 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291104AbSBGEkl>;
	Wed, 6 Feb 2002 23:40:41 -0500
Date: Wed, 06 Feb 2002 20:38:38 -0800 (PST)
Message-Id: <20020206.203838.107294675.davem@redhat.com>
To: greearb@candelatech.com
Cc: alan@lxorguk.ukuu.org.uk, ionut@cs.columbia.edu,
        linux-kernel@vger.kernel.org, cfriesen@nortelnetworks.com
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C6200B5.5060704@candelatech.com>
In-Reply-To: <E16Ydys-0007D6-00@the-village.bc.nu>
	<3C6200B5.5060704@candelatech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Wed, 06 Feb 2002 21:21:09 -0700
   
   Alan Cox wrote:
   
   > UDP is not flow controlled.
   
   If it makes it through sendto, where can it be dropped before it
   hits the wire?

If the packet ends up being fragmented on the way out and the socket
cannot take on the allocation against it's buffer space.
