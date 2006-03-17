Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWCQGf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWCQGf2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 01:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWCQGf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 01:35:27 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:65427 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932072AbWCQGf1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 01:35:27 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: /dev/stderr gets unlinked 8]
Date: Fri, 17 Mar 2006 08:34:27 +0200
User-Agent: KMail/1.8.2
Cc: Andreas Schwab <schwab@suse.de>, Stefan Seyfried <seife@suse.de>,
       linux-kernel@vger.kernel.org, christiand59@web.de
References: <200603141213.00077.vda@ilport.com.ua> <jehd5zq28o.fsf@sykes.suse.de> <Pine.LNX.4.61.0603162111400.11776@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0603162111400.11776@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603170834.27694.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 March 2006 22:11, Jan Engelhardt wrote:
> >> any good daemon closes stdout, stderr, stdin
> >
> >A real good daemon would redirect them to /dev/null.
> 
> and writes to /var/log/mysql/...

And has log rotation. Apache has log rotation. Squid has log rotation.

Why they all need to have log rotation code? I forced them all to just
write log to stderr, and multilog from daemontools does the logging
(with rotation and postprocessing (for example, feeds Squid log into
Mysql db)) just fine.

But we digress. Is there any magic (mount --bind?) to make
/dev/stderr undestructible?
--
vda
