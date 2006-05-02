Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWEBHZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWEBHZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 03:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWEBHZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 03:25:12 -0400
Received: from nproxy.gmail.com ([64.233.182.191]:46767 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932369AbWEBHZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 03:25:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=fv3G3xO/T2waXJ3uJPC/OmUl4pl+F569BM5mCnGSyNZ/73BYxy2QPvB/2sMIwTrbHS99uBvZY21J1v3ry2hg9lRfSHa9F91gaDBLLDjh7VPXzlAfDc2+TIDAqY1wGQVf1suFXVTCfi3u+aF5cN3iD0I0n9IhqMM7ztsghjNqI3E=
Message-ID: <44570929.2080603@gmail.com>
Date: Tue, 02 May 2006 09:24:25 +0200
From: =?ISO-8859-1?Q?Daniel_Aragon=E9s?= <danarag@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: es-ar, es, en-us, en
MIME-Version: 1.0
To: Joshua Hudson <joshudson@gmail.com>
CC: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH/RFC] minix filesystem update to V3. Error comment.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua wrote:

 > Is this the error about variable might not be initalized?
 > What happends in the code if you just initalize to NULL?

Hi all,

No, is not this kind of error. The error message complaints about not beeing able to reference the contents of a pointer if you previously not allocate with kmalloc a location for it. Nothig has to 
bee initialized because the target and contents already exists.

Nothing happens if I initialize to NULL. An exception happens if I later free it with kfree instead of setting it to NULL.

Be aware that all this happens within functions included by bitops.h.

Regards,

Daniel
