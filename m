Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbTJNSDC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTJNSDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:03:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50110 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262635AbTJNSDA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:03:00 -0400
Message-ID: <3F8C3A48.5090703@pobox.com>
Date: Tue, 14 Oct 2003 14:02:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Antonio Vargas <wind@cocodriloo.com>
CC: Daniel Blueman <daniel.blueman@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] [2.4.21] 8139too 'too much work at interrupt'...
References: <16084.1065694106@www3.gmx.net> <20031009163530.GA7001@wind.cocodriloo.com>
In-Reply-To: <20031009163530.GA7001@wind.cocodriloo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonio Vargas wrote:
> This happens to me also on 2.4.18 and 2.4.19 (yes, I know they are old).
> 
> Happens about once every 5 months, with the box running at
> about 1 month uptime per reboot (home server, there is no UPS)


It's fairly normal for this event to occur.  It's due to the 8139 
hardware..  sometimes (perhaps during a DoS or ping flood) you can 
receive far more tiny packets than the driver wishes to deal with in a 
single interrupt.

The real solution is to convert the driver to NAPI...

	Jeff



