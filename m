Return-Path: <linux-kernel-owner+w=401wt.eu-S1751848AbWLNK0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbWLNK0S (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 05:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbWLNK0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 05:26:18 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50536 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751848AbWLNK0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 05:26:17 -0500
Date: Thu, 14 Dec 2006 10:34:35 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 1/1] Char: isicom, remove tty_{hang,wake}up bottomhalves
Message-ID: <20061214103435.0dfcfa1c@localhost.localdomain>
In-Reply-To: <16468312961305320785@karneval.cz>
References: <16468312961305320785@karneval.cz>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 01:35:17 +0100 (CET)
Jiri Slaby <jirislaby@gmail.com> wrote:

> isicom, remove tty_{hang,wake}up bottomhalves
> 
> - tty_hangup() itself schedules work, so there is no need to schedule hangup
>   in the driver
> - tty_wakeup() its safe to call it while in atomic (IS THIS CORRECT?), so that
>   its schedule_work might be also wiped out
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> 

Acked-by: Alan Cox <alan@redhat.com>
