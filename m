Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWCQOce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWCQOce (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 09:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWCQOcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 09:32:33 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:55956 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750889AbWCQOcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 09:32:33 -0500
Date: Fri, 17 Mar 2006 15:32:23 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Denis Vlasenko <vda@ilport.com.ua>
cc: Andreas Schwab <schwab@suse.de>, Stefan Seyfried <seife@suse.de>,
       linux-kernel@vger.kernel.org, christiand59@web.de
Subject: Re: /dev/stderr gets unlinked 8]
In-Reply-To: <200603170834.27694.vda@ilport.com.ua>
Message-ID: <Pine.LNX.4.61.0603171527090.24878@yvahk01.tjqt.qr>
References: <200603141213.00077.vda@ilport.com.ua> <jehd5zq28o.fsf@sykes.suse.de>
 <Pine.LNX.4.61.0603162111400.11776@yvahk01.tjqt.qr> <200603170834.27694.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> any good daemon closes stdout, stderr, stdin
>> >
>> >A real good daemon would redirect them to /dev/null.
>> 
>> and writes to /var/log/mysql/...
>
>And has log rotation. Apache has log rotation. Squid has log rotation.
>
>Why they all need to have log rotation code? I forced them all to just

I dunno. SUSE Linux (no advertisement intended) uses a global solution - 
"logrotate" rather than using each project's own logrotation.


>write log to stderr, and multilog from daemontools does the logging
>(with rotation and postprocessing (for example, feeds Squid log into
>Mysql db)) just fine.
>
>But we digress. Is there any magic (mount --bind?) to make
>/dev/stderr undestructible?

If not, you could write an LSM that prohibits unlinking /dev/stderr.



Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
