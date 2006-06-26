Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWFZNJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWFZNJQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 09:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWFZNJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 09:09:16 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:38352
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932182AbWFZNJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 09:09:15 -0400
Message-ID: <449FDC76.50107@lsrfire.ath.cx>
Date: Mon, 26 Jun 2006 15:09:10 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Troy Benjegerdes <hozer@hozed.org>
CC: Daniel <damage@rooties.de>, linux-kernel@vger.kernel.org
Subject: Re: Kernelsources writeable for everyone?!
References: <200606242000.51024.damage@rooties.de> <20060624181702.GG27946@ftp.linux.org.uk> <20060626071140.GB3359@narn.hozed.org>
In-Reply-To: <20060626071140.GB3359@narn.hozed.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Troy Benjegerdes schrieb:
> On Sat, Jun 24, 2006 at 07:17:02PM +0100, Al Viro wrote:
>> On Sat, Jun 24, 2006 at 08:00:50PM +0200, Daniel wrote:
>>> Hi, may be this was reported/asked 999999999 times, but here ist 
>>> the 1000000000th:
>>> 
>>> I have downloaded linux-2.6.17.1 10 min ago and I noticed that 
>>> every file is writeable by everyone. What's going on there?
>> You are unpacking tarballs as root and preserve ownership and 
>> permissions. Don't.
> 
> While it is true that users generally shouldn't be unpacking tarballs
>  as root, It seems rather monumentally stupid for a trusted source
> for a critical system component (aka, kernel.org) to be distributing 
> tarballs like this.

The permissions info within a tarball doesn't mean anything as long as
the file just sits there.  Only when you interpret the contents and
create files and directories they become relevant.

Tar gives you two options: A) set permissions exactly as stored in the
tar file, or B) apply the umask.  Tar archives created by git are
intended to be interpreted using option B), which is the default for GNU
tar if run as non-root.

You can interpret the tar file correctly even if you are root, you just
have to convince tar to apply the umask.

Best regards,
René
