Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbUKDSZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbUKDSZC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 13:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbUKDSYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 13:24:52 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:56795 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262358AbUKDSWV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 13:22:21 -0500
Date: Thu, 4 Nov 2004 19:24:44 +0100
From: DervishD <lkml@dervishd.net>
To: Paul Slootman <paul+nospam@wurtel.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Message-ID: <20041104182444.GC24522@DervishD>
Mail-Followup-To: Paul Slootman <paul+nospam@wurtel.net>,
	linux-kernel@vger.kernel.org
References: <20041103194226.GA23379@DervishD> <418965E0.8070508@tmr.com> <20041104102655.GB23673@DervishD> <cmde0g$l20$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cmde0g$l20$1@news.cistron.nl>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Paul :)

 * Paul Slootman <paul+nospam@wurtel.net> dixit:
> >    If init is the parent, all works ok, just wait a bit and all
> >those zombies will really die ;)
> I recently had a system with serial console where some some reason the
> serial port was stopped. This meant that init blocked while writing some
> message (e.g. "respawning too rapidly"), and that meant it stopped
> reaping those zombie processes. The list of these zombie processes with
> PPID == 1 was amazing. The only thing that helped was rebooting after
> replacing the serial console cable.

    It looks like a bug in sysvinit: it shouldn't print anything on
the console but use syslog and specify that the console NEVER shall
be used to print anything even when there is no syslogd running. I'll
make sure that it doesn't happen in my VCinit.

    Thanks for the information :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
