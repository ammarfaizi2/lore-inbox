Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264977AbUELF2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264977AbUELF2y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 01:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264978AbUELF2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 01:28:54 -0400
Received: from wl-193.226.227-253-szolnok.dunaweb.hu ([193.226.227.253]:49618
	"EHLO szolnok.dunaweb.hu") by vger.kernel.org with ESMTP
	id S264977AbUELF2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 01:28:53 -0400
Message-ID: <40A1B5A7.9020805@freemail.hu>
Date: Wed, 12 May 2004 07:27:03 +0200
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.4.1) Gecko/20031114
X-Accept-Language: hu, en-US
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Serial ATA (SATA) on Linux status report
References: <40A0A4EC.8050705@freemail.hu> <40A16E21.9080201@pobox.com>
In-Reply-To: <40A16E21.9080201@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik írta:
> Zoltan Boszormenyi wrote:
>> Could it be that Region 1 of the Promise controller contains
>> the PATA I/O ports? Then it could be driven with a drivers/ide
>> driver... Maybe common locking is needed between sata_promise.c
>> and a driver for it's PATA side, I don't know.
> 
> 
> Nope, the PATA ports are stuck in the same place as the SATA ports...
> 
>     Jeff

Then the solution could be be that drivers/ide/ide.c generic
functions must be bridged/duplicated (short term) or moved (long term)
to libata. And maybe in 2.7 drivers/ide ll drivers are rewritten
(again) to use it from there.

Best regards,
Zoltán Böszörményi

