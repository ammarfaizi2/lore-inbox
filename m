Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269349AbRGaQ3V>; Tue, 31 Jul 2001 12:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269353AbRGaQ3L>; Tue, 31 Jul 2001 12:29:11 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:37550 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S269349AbRGaQ3C>; Tue, 31 Jul 2001 12:29:02 -0400
Importance: Normal
Subject: errno for in-kernel syscalls not SMP safe
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFE6555A53.6D16FF49-ONC1256A9A.0059BCD8@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Tue, 31 Jul 2001 18:28:16 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 31/07/2001 18:28:17
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

we just noticed that the 'errno' variable used for in-kernel
syscalls (linux/unistd.h) is not SMP safe.

What would you suggest is the proper way to fix this?

- Use a per-CPU (or maybe per-task) errno value?
- Protect all errno uses with a lock?
- Don't use errno at all, return negative error codes directly?
- anything else I've overlooked?


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

