Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268552AbTGNShs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270660AbTGNShs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:37:48 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:6340 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S268552AbTGNShp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:37:45 -0400
Importance: Normal
Sensitivity: 
Subject: Re: sizeof (siginfo_t) problem
To: Jakub Jelinek <jakub@redhat.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF52924CDC.2DF20D62-ONC1256D63.0066BE2A@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Mon, 14 Jul 2003 20:52:20 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 14/07/2003 20:52:25
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jakub Jelinek wrote:

>As I tried to write, we either can have all GCCs
>which will work properly only with new kernels (no pad added),
>or we can have new GCCs working with all kernels (if pad is added).
>Your choice...

I'll discuss this with Martin tomorrow, but right now I'd tend to
fixing the kernel, because this means you can fix an installed
system by upgrading only the kernel itself (and this upgrade
should not break anything).  The alternative would be not only
to upgrade libgcc (and possibly glibc), but all programs statically
linked with it as well as all programs that otherwise have the
signal stack layout hardcoded ...


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

