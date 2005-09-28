Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVI1XLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVI1XLV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVI1XLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:11:20 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:8551 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751217AbVI1XLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:11:19 -0400
Message-ID: <433B2081.9050607@gentoo.org>
Date: Thu, 29 Sep 2005 00:00:17 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050820)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       posting@blx4.net, vsu@altlinux.ru
Subject: Re: [PATCH] via82cxxx IDE: Remove /proc/ide/via entry
References: <43146CC3.4010005@gentoo.org> <58cb370e05083008121f2eb783@mail.gmail.com> <43179CC9.8090608@gentoo.org> <58cb370e050927062049be32f8@mail.gmail.com> <433B16BD.7040409@gentoo.org> <20050928223718.GB7992@ftp.linux.org.uk>
In-Reply-To: <20050928223718.GB7992@ftp.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

(btw, original subject was wrong, I actually meant /proc/ide/via)

Al Viro wrote:
> Care to explain
> 	* where to get equivalent information?

I don't think there is anywhere else that provides the whole range, but I do 
question the usefulness of most of it :)

Here's my previous attempt at this patch:

	http://marc.theaimsgroup.com/?l=linux-ide&m=112630444000358&w=2

If you can point out a way to keep /proc/ide/via around without causing the 
kind of ugliness found above, then maybe Bart can be persuaded to keep it 
around :)

> 	* what hardware setup has more than one of those controllers?

I'm pushing to get a simple patch merged, which adds ID's for a VIA VT6410 
controller. Apparently these are available in PCI-card form as well as 
onboard-PCI-chip form. Bart raised the concern that this driver wouldn't cope 
well with 2 different controllers in use, so I'm trying to address this.

Thanks,
Daniel
