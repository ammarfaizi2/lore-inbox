Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbUCIRzq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 12:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbUCIRzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 12:55:46 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:56776 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S262077AbUCIRzp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 12:55:45 -0500
Subject: Re: blk_congestion_wait racy?
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OFAAC6B1AC.5886C5F2-ONC1256E52.0061A30B-C1256E52.0062656E@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Tue, 9 Mar 2004 18:54:44 +0100
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 09/03/2004 18:55:12
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hi Nick,

> Another problem is that if there are no requests anywhere in the system,
> sleepers in blk_congestion_wait will not get kicked. blk_congestion_wait
> could probably have blk_run_queues moved after prepare_to_wait, which
> might help.
I tried putting blk_run_queues after prepare_to_wait, it worked but it
didn't help. The test still needs close to a minute.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


