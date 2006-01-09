Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965144AbWAIAKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbWAIAKb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 19:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWAIAKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 19:10:31 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:13779 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965144AbWAIAKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 19:10:31 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 15/15] kconf: Check for eof from input stream.
Date: Mon, 9 Jan 2006 01:09:04 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <0ISL003ZI97GCY@a34-mta01.direcway.com> <Pine.LNX.4.61.0601082158310.8860@spit.home> <1136756494.1043.16.camel@grayson>
In-Reply-To: <1136756494.1043.16.camel@grayson>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601090109.06051.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday 08 January 2006 22:41, Ben Collins wrote:

> That's not entirely acceptable. The reason this shows up is if an
> automatic build is being done, and the config files are not up-to-date,
> the prefered action is a build failure, not selecting defaults. The
> reason for my fix was that instead of filling up diskspace with a
> logfile of kconf's infinite loop, we just exit with an error.
>
> Currently, this is the only way to ensure that these issues don't go
> unnoticed.

Then something is wrong with your automatic build. If the config needs to be 
updated and stdin is redirected during a kbuild, it will already abort.

bye, Roman
