Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131626AbREHLxL>; Tue, 8 May 2001 07:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131644AbREHLxC>; Tue, 8 May 2001 07:53:02 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:23007 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S131626AbREHLws>; Tue, 8 May 2001 07:52:48 -0400
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B27218@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>,
        "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>
Subject: RE: ioctl call for network device
Date: Tue, 8 May 2001 04:52:40 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> struct ifreq has a member called ifr_data. It is a pointer. You can
> put a pointer to any of your data, including the most complex structure
> you might envision, in that area. This allows you to pass anything
> to and from your module. This pointer can be properly dereferenced
> in kernel space but you should use copy_to/from_user and friends so a
> user-space coding bug won't panic the kernel.

How about a linked list ?
Will the driver be able to follow the list where each node was dynamically
allocated by the application ?
Is there a size limit on the buffer ifr_data points to ? (AFAIK, Windows
NDIS drivers limit to 1 page buffer =4096 bytes).


	Thanks,

	Shmulik Hen      
	Linux Advanced Networking Services
	Intel Network Communications Group

