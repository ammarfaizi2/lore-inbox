Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266830AbUHISm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266830AbUHISm0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266846AbUHISaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:30:20 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:34572 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S266837AbUHIS0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:26:51 -0400
Message-ID: <4117C1E6.7070004@superbug.demon.co.uk>
Date: Mon, 09 Aug 2004 19:26:46 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Noah Misch <noah@cs.caltech.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make scsi.h nominally userspace-clean
References: <20040809172406.GA1042@orchestra.cs.caltech.edu>
In-Reply-To: <20040809172406.GA1042@orchestra.cs.caltech.edu>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noah Misch wrote:
> As Joerg Schilling, the author of cdrecord, has noted in threads such as
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0309.3/1355.html and
> http://www.ussg.iu.edu/hypermail/linux/kernel/0408.0/0799.html,
> 
> scsi/scsi.h does not compile cleanly in userspace programs due to its use of
> ``u8''.  I have confirmed this bug and prepared and tested a fix that simply
> changes all such uses to ``__u8''.  Please consider for inclusion.
> 
> I do not argue that including this header file in a program is appropriate, but
> other kernel headers already take as many precautions as this patch introduces.
> I chose __u8 over uint8_t as more in the style of the kernel generally.
> 
> Please keep me on cc:; I do not subscribe to the lists.
> 

Why not use /usr/include/scsi/scsi.h instead of 
/usr/src/linux/include/scsi/scsi.h ?
That already has uint8_t.

