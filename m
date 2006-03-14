Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWCNKNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWCNKNa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 05:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbWCNKNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 05:13:30 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:1441 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750717AbWCNKN3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 05:13:29 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org
Subject: /dev/stderr gets unlinked 8]
Date: Tue, 14 Mar 2006 12:12:59 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603141213.00077.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the bad days of devfsd, no user program could remove /dev/stderr
(bacause fs didn't allow for that).

But I switched to udev sometime ago.

Today I discovered that my mysqld was happily unlinking it and
recreating as regular file in /dev (I pass --log=/dev/stderr
to mysqld).

Can I make /dev/stderr non-unlink-able?
--
vda
