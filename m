Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263392AbTJOPNm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 11:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbTJOPNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 11:13:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36501 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263392AbTJOPNk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 11:13:40 -0400
Message-ID: <3F8D6417.8050409@pobox.com>
Date: Wed, 15 Oct 2003 11:13:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Mouw <erik@harddisk-recovery.com>
CC: Josh Litherland <josh@temp123.org>, linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl>
In-Reply-To: <20031015133305.GF24799@bitwizard.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> On Tue, Oct 14, 2003 at 04:30:50PM -0400, Josh Litherland wrote:
> 
>>Are there any filesystems which implement the transparent compression
>>attribute ?  (chattr +c)
> 
> 
> The NTFS driver supports compressed files. Because it doesn't have
> proper write support, I don't think it will do anything useful with
> chattr +c.
> 
> Nowadays disks are so incredibly cheap, that transparent compression
> support is not realy worth it anymore (IMHO).


Josh and others should take a look at Plan9's venti file storage method 
-- archival storage is a series of unordered blocks, all of which are 
indexed by the sha1 hash of their contents.  This magically coalesces 
all duplicate blocks by its very nature, including the loooooong runs of 
zeroes that you'll find in many filesystems.  I bet savings on "all 
bytes in this block are zero" are worth a bunch right there.

	Jeff



