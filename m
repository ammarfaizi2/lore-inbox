Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVFNPKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVFNPKv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 11:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbVFNPKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 11:10:51 -0400
Received: from gs.bofh.at ([193.154.150.68]:10963 "EHLO gs.bofh.at")
	by vger.kernel.org with ESMTP id S261328AbVFNOzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 10:55:04 -0400
Subject: Re: Add pselect, ppoll system calls.
From: Bernd Petrovitsch <bernd@firmix.at>
To: =?ISO-8859-1?Q?Mattias Engdeg=E5rd?= <mattias@virtutech.se>
Cc: Valdis.Kletnieks@vt.edu, cfriesen@nortel.com, linux-kernel@vger.kernel.org,
       dwmw2@infradead.org
In-Reply-To: <200506141442.j5EEgKJ11377@virtutech.se>
References: <200506131938.j5DJcKc10799@virtutech.se>
	 <42ADE52E.1040705@nortel.com> <200506132008.j5DK8t010817@virtutech.se>
	 <200506132023.j5DKNhoG021339@turing-police.cc.vt.edu>
	 <200506141407.j5EE7sZ11314@virtutech.se>
	 <1118758583.11557.87.camel@tara.firmix.at>
	 <200506141442.j5EEgKJ11377@virtutech.se>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Tue, 14 Jun 2005 16:54:53 +0200
Message-Id: <1118760893.11557.94.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trimmed Cc: so reduce mail on already mail-overloaded folks.

On Tue, 2005-06-14 at 16:42 +0200, =?ISO-8859-1?Q?Mattias Engdeg=E5rd?=
wrote:
> >> I don't have the POSIX specs handy, but I see no reason we could not let
> >> it use a warpless monotonic clock.
> >
> >You have already one - the uptime of the system.
> 
> For example, yes. 
> 
> >Doing "Relative timeouts" with "gettimeofday()" is a strategic error.
> >Specify the timeout und use (the return value of) times(2) for this.
> 
> Having an interface use absolute timeouts will avoid this strategic error,

If the absolute timeouts means "the uptime in some point in the future",
yes.
If the absolute timeouts means "the time in the real world", then it
*is* the strategic error. This "time in the real world" (if it is usable
on the user interface), is neither monotonic nor warpless.

> simplify common code, and reduce the number of needed syscalls.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

