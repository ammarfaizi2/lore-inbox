Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbVIHQPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbVIHQPc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 12:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVIHQPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 12:15:32 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:64426 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964895AbVIHQPa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 12:15:30 -0400
Subject: Re: Ethernet IP multicast maximum packet size
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jagdmann@gmail.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5d0f6099050908083510aa9ab4@mail.gmail.com>
References: <5d0f6099050908083510aa9ab4@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Sep 2005 17:40:25 +0100
Message-Id: <1126197625.19834.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-08 at 17:35 +0200, Dirk Jagdmann wrote:
> Hello developers,
> 
> I googled around all day, but did not find any satisfying answer. Is
> there a maximum packet size when I use IP multicasting in a local
> ethernet LAN? Or more precisely, does the multicast code in Linux
> handle an IP fragmentation/defragmentation of a 63K UDP multicast
> datagram, which is transmitted over an 1500bytes MTU ethernet? Or
> should I stay on the safe edge and don't construct datagrams > 1500 so
> I'll avoid fragmentation?

It is considered good practice to keep local multicast within local MTU.
For remote multicast 576 byte total frames used to be recommended by
some people but MTU discovery and multicast is a real can of worms. (A
google for "multicast implosion" should find some useful material on the
question of discovery and multicast)

