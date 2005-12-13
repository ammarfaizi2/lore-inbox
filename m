Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVLMQCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVLMQCU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 11:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbVLMQCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 11:02:19 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:26511 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932326AbVLMQCT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 11:02:19 -0500
Subject: Re: a question: handling tasks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "KERNEL_C@telefonica.net" <KERNEL_C@telefonica.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9108837.1134487799101.JavaMail.root@ctps7>
References: <9108837.1134487799101.JavaMail.root@ctps7>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 13 Dec 2005 16:02:17 +0000
Message-Id: <1134489737.11732.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-12-13 at 16:29 +0100, KERNEL_C@telefonica.net wrote:
> The thing is that, in case of the user 
> trying to execute another instance of the appl. the already running one 
> could catch the first argument used to call the second instance and 
> pass it through a function.

Not really a kernel question. Various daemons implement something
similar using simple file locks and then sockets to pass messages
between instances of a program.

It's not the usual mentality of Linux/Unix programs but you'll find
examples that do it to look at - one is evolution, another is
mozilla/firefox as shipped by at least Fedora (not all vendors use the
single instance/multiple windows code). Various other gnome apps such as
gnome terminal support this way of working too and Gnome implements a
set of factory objects and activation system for this purpose
