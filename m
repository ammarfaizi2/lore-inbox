Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264120AbTKJVg2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 16:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264121AbTKJVg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 16:36:27 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:10756 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264120AbTKJVg0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 16:36:26 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Date: 10 Nov 2003 21:25:53 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <boovp1$6uc$1@gatekeeper.tmr.com>
References: <3FA69CDF.5070908@gmx.de> <20031105101207.GI1477@suse.de> <3FA8CEF1.1050200@gmx.de> <20031105102238.GJ1477@suse.de>
X-Trace: gatekeeper.tmr.com 1068499553 7116 192.168.12.62 (10 Nov 2003 21:25:53 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031105102238.GJ1477@suse.de>, Jens Axboe  <axboe@suse.de> wrote:

| It isn't a problem of the recorder program. But some drives wont read
| the very end of a disc unless there are some pad blocks at the end.
| Thus, you should always use the cdrecord pad option.

I think the previous answer, some devices will read without pad and some
won't, is probably a good place to stop. It turns out that some device
not only don't need the pad, but will read it if you are in the raw read
mode, and thus "read more than you wrote" of data. For iso9660 images
being mounted the pad option should be used, and I believe that it does
in fact default to on in recent versions of cdrecord.

In any case I would add "with iso9660 images" to your fine advice, and
suggest that getting the iso filesystem size (from isoinfo) and reading
exactly that much is still probably desirable. There are too many TAO
vs. DAO and -pad or not magic solutions, unfortunately, and too much
dubious firmware for anything else to work every time.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
