Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279599AbRKFO5H>; Tue, 6 Nov 2001 09:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279581AbRKFO45>; Tue, 6 Nov 2001 09:56:57 -0500
Received: from gap.cco.caltech.edu ([131.215.139.43]:46763 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S279588AbRKFO4i>; Tue, 6 Nov 2001 09:56:38 -0500
Date: Tue, 6 Nov 2001 09:40:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Terje Eggestad <terje.eggestad@scali.no>
cc: Nicholas Berry <nikberry@med.umich.edu>, amon@vnl.com, weixl@caltech.edu,
        mlist-linux-kernel@nntp-server.caltech.edu
Subject: Re: How can I know the number of current users in the system?
In-Reply-To: <1005054258.1221.122.camel@pc-16.office.scali.no>
Message-ID: <Pine.LNX.3.95.1011106093538.20581A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Nov 2001, Terje Eggestad wrote:

> Absolutly true. 
> 
> You can get a 90% solution by testing for tty and for proces that has a
> connection to a tcp port between 6000 and 6100 somewhere or has a unix
> socket to /tmp/.X11-unix/X0 (or whereever X chooses to place the unix
> socket). 
> 
> But thats definitly not good enough to base your scheduling on.
> 
> TJ

If you don't mind having your Web-Server with 1000 connections/second
be a "single user", just scan for all the unique UID/GID pairs.
All the root processes are one "user", the lpd is another user,
Apache is another user, login-joe is another user, etc. The total
number of tasks is the number of directories that represent digits
in /proc.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


