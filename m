Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316833AbSFZUx7>; Wed, 26 Jun 2002 16:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316831AbSFZUx6>; Wed, 26 Jun 2002 16:53:58 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:60666 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S316827AbSFZUx6>; Wed, 26 Jun 2002 16:53:58 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15642.10680.342020.961228@wombat.chubb.wattle.id.au>
Date: Thu, 27 Jun 2002 06:53:12 +1000
To: "Amit  Agrawal, Noida" <amitag@noida.hcltech.com>
CC: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] new large-block-device patch available
In-Reply-To: <E04CF3F88ACBD5119EFE00508BBB2121033DD4F2@exch-01.noida.hcltech.com>
References: <E04CF3F88ACBD5119EFE00508BBB2121033DD4F2@exch-01.noida.hcltech.com>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Amit" == Amit Agrawal <Amit> writes:

Amit> Hi Peter I think some places in files 'pagemap.h' and
Amit> 'filemap.c' still uses unsigned long instead of sector_t,these
Amit> files are not touched by your patch, please see to it........

The `index' in pagemap.h and filemap.c is an index into the pagecache,
not a disk offset --- so it stays as unsigned long.  I think there are
plans to change it to `pgoff_t', or to change the size of an object in
the pagecacheat some stage, but for now the
pagecache on a 32-bit architecture is limited to addressing 
((2^32)-1) * PAGECACHE_SIZE, which makes a limit of 16TB on 32-bit
architectures at present.  

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.

