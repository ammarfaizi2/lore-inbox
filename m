Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264768AbTGBG2Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 02:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264770AbTGBG2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 02:28:24 -0400
Received: from tag.witbe.net ([81.88.96.48]:39174 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S264768AbTGBG2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 02:28:21 -0400
From: "Paul Rolland" <rol@as2917.net>
To: "'Helge Hafting'" <helgehaf@aitel.hist.no>,
       "'Jesse Pollard'" <jesse@cats-chateau.net>
Cc: "'Fredrik Tolf'" <fredrik@dolda2000.cjb.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: PTY DOS vulnerability?
Date: Wed, 2 Jul 2003 08:42:18 +0200
Message-ID: <028001c34065$15777250$4100a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <20030701195323.GA15483@hh.idb.hist.no>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > second, just providing a user limit doesn't prevent a denial of 
> > service.. Just have more connections than ptys and you are 
> in the same 
> > situation.
> 
> Isn't this something a improved sshd could do?  I.e. if the 
> connection using up the last (or one of the last) pty's logs 
> in as non-root - just kill it.

Why restricting this to SSH ? I mean, this can occur even if you
are not using SSH.

Some per-user limit seems to be good... but if we do that, what about
also limiting the number of TCP/UDP ports used on a per-user basis ?

In fact, all the resources that are available should be per-user limited
if you want to avoid a single one causing a complete DoS...
 - CPU
 - Memory
 - Network
 - Disk
 - Pty
 - ...

Paul

