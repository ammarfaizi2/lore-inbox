Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266827AbUBQXRi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266826AbUBQXQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:16:44 -0500
Received: from netti-3-265.dyn.nic.fi ([212.38.238.10]:2282 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266827AbUBQXO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:14:58 -0500
From: Jan Knutar <jk-lkml@sci.fi>
To: linux-kernel@vger.kernel.org
Subject: mem=  parameter, 2.4.18 vs 2.4.24
Date: Tue, 17 Feb 2004 19:08:59 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402171908.27583.jk-lkml@sci.fi>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just upgraded an old computer from 2.4.18 to 2.4.24. The system has 24M 
ram, but the bios reports only 16.

Discovered that mem=24M doesn't let Linux use all of it, like in 2.4.18, 
only 16M in 2.4.24.

mem=8M@16M has the desired result, making the whole incredibly large 24M 
ram available :-)

RTFSing leads me to believe that mem=xxxM can only limit ram size, but 
Documentation/memory.txt and Documentation/kernel-parameters.txt make 
me think ram=24M should work like it did in 2.4.18.  I'm guessing 
nobody updated the documentation? :)

