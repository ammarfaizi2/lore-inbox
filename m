Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130384AbRCPJ5j>; Fri, 16 Mar 2001 04:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130388AbRCPJ53>; Fri, 16 Mar 2001 04:57:29 -0500
Received: from smtp.alcove.fr ([212.155.209.139]:24586 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S130384AbRCPJ5W>;
	Fri, 16 Mar 2001 04:57:22 -0500
Date: Fri, 16 Mar 2001 10:56:38 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: linux-kernel@vger.kernel.org
Subject: Q: multiple task queues performance ?
Message-ID: <20010316105638.B6384@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I'm writing a driver for a ISDN card which needs to be able
to send data to several channels, each channel having its own
flow control flag.

Actually, I use one send queue (sk_buff_head) and one task queue 
(tq_struct) for each channel, the task being controled by the
flow flag and queued on tq_immediate.

The problem is that some versions of the same ISDN card are able
to manage up to 256 ISDN channels, so the driver could end up
having 256 task queues queued on tq_immediate...

Is this The Good Way(tm) to do the job or 256 task queues implies
too much overhead and I should reimplement the access to the channels
using only one task queue and do some polling policy on the 
channels myself ?

Thanks.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|------------- Ingénieur Informatique Libre --------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|----------- Alcôve, l'informatique est libre ------------|
