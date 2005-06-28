Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVF1JTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVF1JTS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 05:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVF1JTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 05:19:18 -0400
Received: from bay19-f12.bay19.hotmail.com ([64.4.53.62]:25004 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262023AbVF1JSK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 05:18:10 -0400
Message-ID: <BAY19-F12535FB21F6E7AB66158479CE10@phx.gbl>
X-Originating-IP: [81.155.14.152]
X-Originating-Email: [dcb314@hotmail.com]
From: "d binderman" <dcb314@hotmail.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 28 Jun 2005 09:18:09 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 28 Jun 2005 09:18:10.0040 (UTC) FILETIME=[4D488F80:01C57BC2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello there,

I just tried to compile the Linux Kernel version 2.6.11.12
with the gcc 4.0 compiler. The compiler said

drivers/net/depca.c:1829: warning: operation on 'i' may be undefined

The source code is

for (i = entry; i != end; i = (++i) & lp->txRingMask) {

I agree with the compiler. Better code is

for (i = entry; i != end; i = (i + 1) & lp->txRingMask) {

Regards

David Binderman

_________________________________________________________________
Be the first to hear what's new at MSN - sign up to our free newsletters! 
http://www.msn.co.uk/newsletters

