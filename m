Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264285AbUAVFIN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 00:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUAVFIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 00:08:12 -0500
Received: from mail002.syd.optusnet.com.au ([211.29.132.32]:57560 "EHLO
	mail002.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264285AbUAVFIL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 00:08:11 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Deadline for video capture
Date: Thu, 22 Jan 2004 16:08:00 +1100
User-Agent: KMail/1.5.3
Cc: Nick Piggin <piggin@cyberone.com.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200401221608.05924.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all

I suspected that the anticipatory scheduler might not have been the best 
choice for video capture because of the interruption to writes by reads and 
the subsequent anticipatory delay associated with it.  I have now confirmed 
that booting with the default anticipatory i/o elevator I get many dropped 
frames that I don't get if I boot with elevator=deadline. 

briefly: dual 7200 rpm ATA5 IDE drives in software RAID0

I guess there isn't really a lot to do about this, it's a compromise one way 
or the other. The anticipatory scheduler seems better all round but in this 
large streaming write situation it doesn't seem ideal. Any sysctl settings I 
could use to blunt the anticipation just before I do video capture?

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAD1qzZUg7+tp6mRURAuekAJ9pFVgSLkY7zr4TL7CEfdRfKdp1DQCfUC6T
RnALyU70HgP9AQt8LS4+B6M=
=H3WY
-----END PGP SIGNATURE-----

