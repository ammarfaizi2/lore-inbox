Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTFDQEZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 12:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTFDQEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 12:04:25 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:34779 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263496AbTFDQEY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 12:04:24 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Vladimir Saveliev <vs@namesys.com>
Organization: namesys
To: linux-kernel@vger.kernel.org
Subject: file write performance drop between 2.5.60 and 2.5.70
Date: Wed, 4 Jun 2003 20:17:53 +0400
User-Agent: KMail/1.4.1
Cc: reiserfs-dev@namesys.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306042017.53435.vs@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

It looks like file write performance dropped somewhere between 2.5.60 and 
2.5.70.
Doing
time dd if=/dev/zero of=file bs=4096 count=60000

on a box with Xeon(TM) CPU 2.40GHz and 1gb of RAM
I get for ext2
2.5.60: 	real	1.42 sys 0.77
2.5.70: 	real 1.73 sys 1.23
for reiserfs
2.5.60: 	real 1.62 sys 1.56
2.5.70: 	real 1.90 sys 1.86

Any ideas of what could cause this drop?

Thanks,
vs


