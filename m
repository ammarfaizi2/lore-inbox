Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbVJOQaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVJOQaZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 12:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVJOQaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 12:30:25 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:48828 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751182AbVJOQaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 12:30:25 -0400
Subject: Re: [BUG?] 2.6.x (2.6.13) - new signals not being delivered to a 
	terminating (PF_EXITING) process.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: "Kilau, Scott" <Scott_Kilau@digi.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <43512AD5.852E44AC@tv-sign.ru>
References: <43512AD5.852E44AC@tv-sign.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 15 Oct 2005 17:59:34 +0100
Message-Id: <1129395575.17009.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-10-15 at 20:14 +0400, Oleg Nesterov wrote:
> The intent was to find another thread in the thread group which can accept
> this signal. May be we need special check in __group_complete_signal() under
> "else if (thread_group_empty(p))".

The serial layer effectively relies on the old behaviour so yes.

