Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269660AbTGMPcK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 11:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269691AbTGMPcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 11:32:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21421 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269660AbTGMPcI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 11:32:08 -0400
Message-ID: <3F117EE3.5010200@pobox.com>
Date: Sun, 13 Jul 2003 11:46:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andrey Borzenkov <arvidjaar@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: Avoiding "unused variable" warnings
References: <200307131932.24015.arvidjaar@mail.ru>
In-Reply-To: <200307131932.24015.arvidjaar@mail.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov wrote:
> I think I have seen it somewhere but forgot.
> 
> Is it possible to create a noop macro that makes compiler believe macro 
> arguments are used? I mean the case of debug macro that for debug off is 
> redefined as something like do { } while(0) but then if arguments are used 
> for debugging purposes only compiler emits warning. Some people do not like 
> it :)


No need for a macro, just do

	(void) var_name;

It doesn't generate any code, and it shuts up the compiler.

	Jeff



