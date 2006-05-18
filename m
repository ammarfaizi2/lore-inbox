Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWERKmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWERKmA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 06:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWERKmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 06:42:00 -0400
Received: from mail.tm.informatik.uni-frankfurt.de ([141.2.4.18]:29633 "EHLO
	mail.tm.informatik.uni-frankfurt.de") by vger.kernel.org with ESMTP
	id S1750830AbWERKmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 06:42:00 -0400
Subject: Re: How should Touchscreen Input Drives behave (OpenEZX pcap_ts)
From: "Michael 'Mickey' Lauer" <mickey@tm.informatik.uni-frankfurt.de>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Harald Welte <laforge@gnumonks.org>, openezx-devel@lists.gnumonks.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1147945947.20943.22.camel@localhost.localdomain>
References: <20060518070700.GT17897@sunbeam.de.gnumonks.org>
	 <1147945947.20943.22.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Institute of Computer Science, University of Frankfurt
Date: Thu, 18 May 2006 14:44:33 +0200
Message-Id: <1147956274.9429.27.camel@gandalf.tm.informatik.uni-frankfurt.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 18.05.2006, 10:52 +0100 schrieb Richard Purdie:
> Just send the raw data to userspace. Any translations needed can be
> handled in userspace by the calibration program. You probably want to
> have a look at tslib: http://cvs.arm.linux.org.uk/cgi/viewcvs.cgi/tslib/

Right. We have very good experience with tslib. The kdrive xserver
supports it and we recently added tslib support to Qt/Embedded (Opie)
and to Evas (EFL).

> Calibration happens in userspace and tslib stores the result
> in /etc/pointercal. If you device has this data stored in hardware, you
> could have a userspace app translate that data into such a file,
> otherwise, you can run a calibration program such as ts_calibrate (from
> tslib) or something like xtscal.

ts_calibrate does a good job. It's pretty easy to use the calibration
API and we have added customized calibration utilities in Opie, GPE and
E to make the calibration phase match the look and feel with the main
GUI.

> I'm told you're thinking about using OpenEmbedded and would highly
> recommend it. It should easily be able to provide a known working
> userspace with tslib and these tools in.

I agree.

-- 
Regards,

Mickey.
------------------------------------------------------------------
Dipl.-Inf. Michael 'Mickey' Lauer <mickey@tm.cs.uni-frankfurt.de>
------------------------------------------------------------------


