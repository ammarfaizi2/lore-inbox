Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264829AbTE1TEp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 15:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264832AbTE1TEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 15:04:45 -0400
Received: from adsl-b3-75-137.telepac.pt ([213.13.75.137]:22989 "HELO
	puma-vgertech.no-ip.com") by vger.kernel.org with SMTP
	id S264829AbTE1TEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 15:04:44 -0400
Message-ID: <3ED50C5C.9010309@vgertech.com>
Date: Wed, 28 May 2003 20:22:04 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4 bug: fifo-write causes diskwrites to read-only fs !
References: <20030528175842.GA13657@verdi.et.tudelft.nl>
In-Reply-To: <20030528175842.GA13657@verdi.et.tudelft.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rob van Nieuwkerk wrote:
> Hi all,
> 
> It turns out that Linux is updating inode timestamps of fifos (named
> pipes) that are written to while residing on a read-only filesystem.
> It is not only updating in-ram info, but it will issue *physical*
> writes to the read-only fs on the disk !

Hi!

I can't give a solution but the workaround is obvious:
mount -t ramfs none /myFifos

Regards,
Nuno Silva



