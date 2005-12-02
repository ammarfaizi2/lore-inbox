Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVLBQ2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVLBQ2t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 11:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVLBQ2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 11:28:49 -0500
Received: from rs02.intra2net.com ([81.169.173.116]:59863 "EHLO
	rs02.intra2net.com") by vger.kernel.org with ESMTP id S1750806AbVLBQ2s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 11:28:48 -0500
From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Organization: Intra2net AG
To: linux-kernel@vger.kernel.org
Subject: sata performance with 2.4.32 + latest libata
Date: Fri, 2 Dec 2005 17:28:35 +0100
User-Agent: KMail/1.8.3
Cc: linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512021728.35130.thomas.jarosch@intra2net.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just tried kernel 2.4.32 + latest libata patches from 2005-12-01
after my performance problems described here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=113171290329839

Now the machine is performing very fast :-)

Results with 2.4.32 + libata latest:
Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
proliant         2G 33294  91 57592  20 26778   5 30885  77 56081   5 174.2   0
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16 27313 100 +++++ +++ 26421  99 27285 101 +++++ +++ 21477  89
proliant,2G,33294,91,57592,20,26778,5,30885,77,56081,5,174.2,0,16,27313,100,+++++,+++,26421,99,27285,101,+++++,+++,21477,89

Previous results with kernel 2.4.32-rc3:
Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
proliant         2G 10523  28 11532   3  7162   1 24271  60 53495   5 164.3   0
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16 30498 100 +++++ +++ 27244  98 29630  99 +++++ +++ 11587  46
proliant,2G,10523,28,11532,3,7162,1,24271,60,53495,5,164.3,0,16,30498,100,+++++,+++,27244,98,29630,99,+++++,+++,11587,46

A RAID1 rebuild went from 6-8 mb/s to this:
[=================>...]  recovery = 85.9% (2202816/2562240) finish=0.1min speed=56280K/sec


Thanks Jeff, you rock.

Thomas
