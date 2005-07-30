Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263011AbVG3IT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbVG3IT1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 04:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbVG3IST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 04:18:19 -0400
Received: from bay19-f12.bay19.hotmail.com ([64.4.53.62]:32968 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263011AbVG3IRt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 04:17:49 -0400
Message-ID: <BAY19-F12E0E449458BCA97C418069CC10@phx.gbl>
X-Originating-IP: [81.154.215.224]
X-Originating-Email: [dcb314@hotmail.com]
From: "d binderman" <dcb314@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: file kernel/signal.c, 2 * array subscript out of range
Date: Sat, 30 Jul 2005 08:17:48 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 30 Jul 2005 08:17:48.0961 (UTC) FILETIME=[2C2BC110:01C594DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

I just tried to compile Redhat Fedora package
kernel-2.6.12-1.1435_FC5 with the Intel C compiler version 8.1

The compiler said

kernel/signal.c(196): warning #175: subscript out of range

The source code is

        case 4: ready  = signal->sig[3] &~ blocked->sig[3];

Clearly broken code. Array sig has only _NSIG_WORDS elements,
which is set to two on this architecture.

Suggest rework code to use _NSIG_WORDS as the upper limit, not
a fixed constant.

The compiler also said

kernel/signal.c(197): warning #175: subscript out of range

on the next line of source code.


Regards

David Binderman

_________________________________________________________________
Want to block unwanted pop-ups? Download the free MSN Toolbar now!  
http://toolbar.msn.co.uk/

