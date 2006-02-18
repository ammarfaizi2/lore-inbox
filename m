Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWBRAta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWBRAta (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWBRAta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:49:30 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:23648 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751500AbWBRAt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:49:29 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kbuild: Section mismatch warnings
Date: Fri, 17 Feb 2006 19:49:26 -0500
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       Paul Bristow <paul@paulbristow.net>, mpm@selenic.com,
       B.Zolnierkiewicz@elka.pw.edu.pl, kkeil@suse.de,
       linux-dvb-maintainer@linuxtv.org, philb@gnu.org, gregkh@suse.de,
       dwmw2@infradead.org
References: <20060217214855.GA5563@mars.ravnborg.org> <20060217224702.GA25761@mars.ravnborg.org>
In-Reply-To: <20060217224702.GA25761@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602171949.27532.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 February 2006 17:47, Sam Ravnborg wrote:
> Several warnings are refereces to module parameters - sound/oss/mad16.o
> as the most visible one. I have not yet figured out if this is a false
> positive or not. Removing __initdata on the moduleparam variable solves
> it, but then this may be the wrong approach.
> 

It looks like your check does not like when data associated with a module
parameter is marked __initdata. But I think it is allowed as long as
module parameter access mode is 0 so we don't create sysfs entry for it. 

-- 
Dmitry
