Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268259AbUHXUjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268259AbUHXUjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268295AbUHXUjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:39:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65191 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268280AbUHXUig
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:38:36 -0400
Message-ID: <412BA741.4060006@pobox.com>
Date: Tue, 24 Aug 2004 16:38:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: akpm@osdl.org, reiser@namesys.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de>
In-Reply-To: <20040824202521.GA26705@lst.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
>  o files as directories
>    - O_DIRECTORY opens succeed on all files on reiser4.  Besides breaking
>      .htaccess handling in apache and glibc compilation this also renders
>      this flag entirely useless and opens up the races it tries to
>      prevent against cmpletely useless


Ouch.

I would definitely classify this as a security hole, since userland 
definitely uses O_DIRECTORY to avoid races.

	Jeff


