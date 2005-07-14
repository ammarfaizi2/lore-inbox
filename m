Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVGNQUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVGNQUx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 12:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVGNQUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 12:20:53 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:32492 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261444AbVGNQUu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 12:20:50 -0400
Date: Thu, 14 Jul 2005 18:23:38 +0200
From: DervishD <lkml@dervishd.net>
To: kernel <kernel@crazytrain.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Konstantin Kudin <konstantin_kudin@yahoo.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: fdisk: What do plus signs after "Blocks" mean?
Message-ID: <20050714162338.GA216@DervishD>
Mail-Followup-To: kernel <kernel@crazytrain.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Konstantin Kudin <konstantin_kudin@yahoo.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	linux-kernel@vger.kernel.org
References: <20050712204822.84567.qmail@web52001.mail.yahoo.com> <Pine.LNX.4.61.0507131222300.14635@yvahk01.tjqt.qr> <1121349002.3718.11.camel@crazytrain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1121349002.3718.11.camel@crazytrain>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Hi kernel.

 * kernel <kernel@crazytrain.com> dixit:
> First 446 bytes are boot code and all
> Next 64 bytes are for 4 partition records, 16 bytes each
> Last 2 bytes are signature 

    And that's right, but only for the MBR. If you set up an extended
partition in the MBR, the partition table for that extended partition
is on the boot record of the extended partition. If you just backup
the MBR, you only backup the *declaration* of the extended partition
(where it starts, where it ends, etc.) but NOT the partition table of
the extended partition (that is, the partitions within the extended
partition). For storing that you have to backup the first sector of
the extended partition itself. And you have to do it recursively if
you want to backup any partition setup, no matter how strange.

    I hope I've made this clear, is a bit difficult to explain
without a couple of diagrams O:)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
