Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268563AbUHLNlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268563AbUHLNlp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 09:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268559AbUHLNlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 09:41:44 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.78]:36485 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S268563AbUHLNlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 09:41:12 -0400
Date: Thu, 12 Aug 2004 09:41:00 -0400
From: Nathan Bryant <nbryant@optonline.net>
Subject: Re: [PATCH] SCSI midlayer power management
In-reply-to: <1092314892.1755.5.camel@mulgrave>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@ucw.cz>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Message-id: <411B736C.7030103@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
References: <4119611D.60401@optonline.net> <20040811080935.GA26098@elf.ucw.cz>
 <411A1B72.1010302@optonline.net> <1092231462.2087.3.camel@mulgrave>
 <1092267400.2136.24.camel@gaston> <1092314892.1755.5.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

>Why?  We don't do a bus reset on boot, why should we need to do one on
>resume?  For FC, the equivalent, a LIP Reset can be rather nasty on a
>SAN and should be avoided.
>  
>
that can be host specific. aic7xxx does a bus reset on boot, so i 
preserved this on resume.

don't know why they do it, but they do.

>The slight problem is probably going to be knowing that we may need to
>spin up devices (for internal ones) before resuming operation.
>  
>
that's easy for system suspend, but somewhat harder for device suspend
