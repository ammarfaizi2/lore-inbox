Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWDERoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWDERoi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 13:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWDERoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 13:44:38 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:24247 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751311AbWDERoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 13:44:38 -0400
Subject: Re: [Alsa-devel] [2.6.17-rc1] ALSA oops with multiple OSS clients
From: Lee Revell <rlrevell@joe-job.com>
To: Luca <kronos.it@gmail.com>
Cc: linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org
In-Reply-To: <20060405173002.GA5306@dreamland.darkstar.lan>
References: <20060405173002.GA5306@dreamland.darkstar.lan>
Content-Type: text/plain
Date: Wed, 05 Apr 2006 13:44:32 -0400
Message-Id: <1144259073.10626.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-05 at 19:30 +0200, Luca wrote:
> Hello,
> I've a reproducible OOPS when starting multiple OSS clients.
> To reproduce I do this:
> mpg123 song.mp3
> mpg123 song.mp3 (another time)
> 
> At this point the song restart from the beginning (i.e. I think that 
> the second mpg123 takes over the device). When the second instance
> terminates the song I get the following OOPS:

Known bug, please try the patch:

http://bugzilla.kernel.org/show_bug.cgi?id=6329

Lee

