Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132101AbRDEA66>; Wed, 4 Apr 2001 20:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132109AbRDEA6r>; Wed, 4 Apr 2001 20:58:47 -0400
Received: from dsl-64148113113.internetconnect.net ([64.148.113.113]:59435
	"HELO infratron.believe.com") by vger.kernel.org with SMTP
	id <S132101AbRDEA6g>; Wed, 4 Apr 2001 20:58:36 -0400
Message-ID: <3ACBC361.CA701A2D@believe.com>
Date: Wed, 04 Apr 2001 17:59:13 -0700
From: John Weidman <johnw@believe.com>
Organization: Believe
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0-bigphys i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Is jumbo ethernet MTU possible with Hamachi Gigabit ethernet driver?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get some Gigabit ethernet cards that use the Packet
Engines Hamachi GNIC-II chip to use a large mtu to attempt to get a
throughput of close to the 1Gb rating of the card.  This is on a Compact
PCI Alpha system.  I'm trying to use an MTU in the 8000 to 9000 range
and so far have not been able to get these MTUs to work.

I have changed the PKT_BUF_SZ and MAX_FRAME_SIZE constants in hamachi.c
and ETH_DATA_LEN and ETH_FRAME_LEN in if_ether.h.  I can use ifconfig to
change the MTU above 1500 on one side of a connection but as soon as I
raise the MTU on both sides to greater than 1500 the link dies.  I can
change the MTU with ifconfig back to 1500 and the link will resume
operation.  We are currently somewhat married to the 2.2.14 kernel.

I read that some ethernet drivers will support jumbo MTUs.  There
appears to be something in the hamachi driver or the kernel that I've
missed.  Perhaps this only works with a later version kernel or the
hamachi driver needs more changes?  Any help would be appreciated.

John Weidman
johnw@believe.com


