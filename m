Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290547AbSBOSU6>; Fri, 15 Feb 2002 13:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290561AbSBOSUs>; Fri, 15 Feb 2002 13:20:48 -0500
Received: from pc-80-195-34-114-ed.blueyonder.co.uk ([80.195.34.114]:3972 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S290547AbSBOSUg>; Fri, 15 Feb 2002 13:20:36 -0500
Date: Fri, 15 Feb 2002 18:19:32 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: RFC: one solution to sys_sync livelock fix
Message-ID: <20020215181932.B5074@redhat.com>
In-Reply-To: <Pine.LNX.3.96.1020213172509.12448G-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96.1020213172509.12448G-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Wed, Feb 13, 2002 at 05:37:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 13, 2002 at 05:37:42PM -0500, Bill Davidsen wrote:

> What would happen if the sync(2) call from a non-root user were treated as
> if it were an fsync(2) call on every file open for write?

Then you'd lose writes for files you have written to but since
closed; and you'd seriously hurt the users of journaling filesystems
who assume you can "sync" as an unprivileged user and then turn power
off.

--Stephen
