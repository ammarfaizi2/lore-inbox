Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbUCUUSf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 15:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUCUUSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 15:18:34 -0500
Received: from mail.gmx.de ([213.165.64.20]:41180 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261214AbUCUUSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 15:18:33 -0500
X-Authenticated: #21910825
Message-ID: <405DF83C.2040703@gmx.net>
Date: Sun, 21 Mar 2004 21:17:00 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Andi Kleen <ak@suse.de>,
       Miquel van Smoorenburg <miquels@cistron.nl>
Subject: Re: [PATCH] fix tiocgdev 32/64bit emul
References: <405DC698.4040802@pobox.com> <20040321165752.A9028@infradead.org> <405DE3EF.8090508@gmx.net> <20040321185538.A10504@infradead.org> <405DF3C6.8050508@gmx.net> <20040321200211.A11109@infradead.org>
In-Reply-To: <20040321200211.A11109@infradead.org>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sun, Mar 21, 2004 at 08:57:58PM +0100, Carl-Daniel Hailfinger wrote:
> 
>>Christoph: Have you looked at my question regarding
>>/sys/class/tty/console/dev ?
> 
> 
> No, I'll leave that to Greg.  If you want my 2 (Euro-) Cent I'd rather avoid
> exposing a dev_t to userspace wherever possible.

Understood. Especially since the recent upsizing of dev_t broke
applications trying to be too clever about dev_t. However, look at this:

# cat /sys/class/tty/console/dev
5:1

Does this major:minor textfile export address your concerns?


Regards,
Carl-Daniel

