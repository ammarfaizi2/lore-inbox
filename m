Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262692AbVBYN1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbVBYN1N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 08:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVBYN1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 08:27:13 -0500
Received: from pat.uio.no ([129.240.130.16]:42461 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262692AbVBYN1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 08:27:10 -0500
To: James Colannino <lkml@colannino.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to capture kernel panics
References: <52765.69.93.110.242.1109288148.squirrel@69.93.110.242>
	<421E96AF.1070908@colannino.org>
From: Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>
Organization: Universitas Osloensis
Date: Fri, 25 Feb 2005 14:26:57 +0100
In-Reply-To: <421E96AF.1070908@colannino.org> (James Colannino's message of
 "Thu, 24 Feb 2005 19:08:31 -0800")
Message-ID: <15toee8lqhq.fsf@klodrik.uio.no>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.976, required 12,
	autolearn=disabled, AWL 0.02, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Colannino <lkml@colannino.org> writes:

> shabanip wrote:
>
>>is there any way to capture and log kernel panics on disk or ...?
>
> My guess would be, at the very least, it depends on what part of the
> kernel is causing the panic.

A kernel panic means that the kernel no longer knows what it's doing,
and therefore stops doing anything immediately. Hence it won't use the
filesystems and cannot log the panic to anything but the console. I
would think the best solution to your problem is to set up a serial
console to another machine, and log everything to disk on that
machine. See Documentation/serial-console.txt for how to set up a
serial console.

Regards,

-- 
Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>
Center for Information Technology Services, University of Oslo
