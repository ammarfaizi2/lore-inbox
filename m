Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266633AbSLJGTm>; Tue, 10 Dec 2002 01:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266631AbSLJGTm>; Tue, 10 Dec 2002 01:19:42 -0500
Received: from mail.webmaster.com ([216.152.64.131]:7577 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S266623AbSLJGTl> convert rfc822-to-8bit; Tue, 10 Dec 2002 01:19:41 -0500
From: David Schwartz <davids@webmaster.com>
To: <daw@mozart.cs.berkeley.edu>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Mon, 9 Dec 2002 22:27:23 -0800
In-Reply-To: <at3v15$mur$1@abraham.cs.berkeley.edu>
Subject: Re: capable open_port() check wrong for kmem
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20021210062724.AAA6047@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10 Dec 2002 05:45:09 GMT, David Wagner wrote:

>carbonated beverage  wrote:

>>    I found that I can't open /dev/kmem O_RDONLY.  The open_mem
>>and open_kmem calls (open_port()) in drivers/char/mem.c checks for
>>CAP_SYS_RAWIO.

>>    Is there a possibility of splitting that off into a read and
>>write pair, i.e. CAP_SYS_RAWIO_WRITE, CAP_SYS_RAWIO_READ?

>Read-only access to /dev/kmem is probably enough to get root access
>(maybe you can snoop root's password, for instance).  This would make
>the power of the two capabilities roughly equivalent, so if this is true,
>I'm not sure I understand the point of splitting them in two this way.

	Many capabilities can be leveraged into root access with sufficient 
cleverness. If this were considered a sufficient argument for merging 
capabilities, we'd have far fewer of them.

	DS


