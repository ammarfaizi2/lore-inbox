Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbULNPix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbULNPix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 10:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbULNPix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 10:38:53 -0500
Received: from bigeats.dufftech.com ([69.57.156.29]:15249 "HELO
	bigeats.dufftech.com") by vger.kernel.org with SMTP id S261525AbULNPiv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 10:38:51 -0500
Subject: bind() udp behavior 2.6.8.1
From: Adam Denenberg <adam@dberg.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1103038728.10965.12.camel@sucka>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Dec 2004 10:38:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 I am not subscribed to this list so please CC me personally in
response. 

 I am noticing some odd behavior with linux 2.6.8.1 on a redhat 8 box
when making udp requests.  It seems subsequent udp calls are all
allocating the same source ephemeral udp port.  I believe the kernel
should be randomizing these (or incrementing) these ports for subsequent
requests.  We ran a test C program that just put a gethostbyname_r call
in a for loop of 40 calls and all 40 requests used the same UDP source
port (32789).  This is causing our firewall to drop some packets since
it thinks it already closed that connection due to too many transactions
using same udp source/dest port passing thru in too short a time frame.

Is this a bug in how the linux kernel handles allocating udp source
ports? Freebsd seems to not do this, so i dont think this is a standard
methodology of how UDP/IP should function.

Any help would be appreciated..

thanks
adam


