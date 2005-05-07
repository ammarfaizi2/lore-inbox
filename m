Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbVEGPMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbVEGPMg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 11:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVEGPMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 11:12:36 -0400
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:29168
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S262613AbVEGPLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 11:11:13 -0400
Message-ID: <427CDA8C.1050607@ev-en.org>
Date: Sat, 07 May 2005 16:11:08 +0100
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: li nux <lnxluv@yahoo.com>
Cc: linux <linux-kernel@vger.kernel.org>
Subject: Re: oprofile: profiling kernel
References: <20050507124513.95097.qmail@web60518.mail.yahoo.com>
In-Reply-To: <20050507124513.95097.qmail@web60518.mail.yahoo.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

li nux wrote:
> Using oprofile Is it possible to profile how many
> times  a function say try_to_unmap_cluster() is called
> within the kernel in a certain time interval ?
> If yes, then how ?
> What settings are needed for that.

No. That's not possible with oprofile.

To get something like that I hack the code and use relayfs to transfer 
the data to user-space.

Note, the examples for relayfs show using sprintf to generate text 
output. *Don't* do that. Use binary buffers and translate them to text 
off-line in user-mode. sprintf is awfully inefficient for large amounts 
of data.

Baruch
