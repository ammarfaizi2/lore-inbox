Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbUCFXdw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 18:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbUCFXdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 18:33:52 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:57862 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261728AbUCFXdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 18:33:50 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Lawrence Walton <lawrence@the-penguin.otak.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: server migration
Date: Sun, 7 Mar 2004 01:33:07 +0200
User-Agent: KMail/1.5.4
References: <20040305181322.GA32114@the-penguin.otak.com>
In-Reply-To: <20040305181322.GA32114@the-penguin.otak.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403070133.07784.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 March 2004 20:13, Lawrence Walton wrote:
> Hi all!
>
> I tried about four months ago to migrate a busy server to 2.6.0-test9,
> and failed miserably. Lightly loaded it worked well but as the number
> of users increased, the number of processes in uninterruptible sleep
> increased to the hundreds and then the server fell on it's face. I never
> found out exactly why or what processes where hanging if I guessed it
> would be openldap.

Why do you guess? Determine what processes are stuck.

> I'd like to take another shot at it with 2.6.3, I'd also like to get
> some hints on how better to debug the problem; remember it is a live
> server with live users, I can't spend much time before rebooting back to
> a 2.4 kernel and yes 2.4.25 runs fine.
>
> Things that are non-standard
>
> Lots of open files, it's not unusual to have 50000 open files.
> ext3 is mounted noatime,data=writeback on /home and /var
> Total processes are usually around 300 to 350.
>
> Main applications are:
>
> imap, exim and openldap running on Debian.
>
> Questions, comments, flames are welcome.

Compile with stack pointers, capture SysRq-T, post stack traces
of D processes to lkml.
--
vda


