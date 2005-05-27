Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbVE0KdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVE0KdP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 06:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVE0KdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 06:33:15 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:9901 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S262425AbVE0Kc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 06:32:56 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 27 May 2005 12:31:28 +0200
To: schilling@fokus.fraunhofer.de, patrakov@ums.usu.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Joerg Schilling flames Linux on his Blog
Message-ID: <4296F700.nail3N024IIC6@burner>
References: <42947A75.nail1XA2FQPXX@burner>
 <B12D948C-4CE9-4139-B0D6-68F8526D0F43@mac.com>
 <4295A1A5.nail2SW21JHSO@burner>
 <200505261847.54977.patrakov@ums.usu.ru>
In-Reply-To: <200505261847.54977.patrakov@ums.usu.ru>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alexander E. Patrakov" <patrakov@ums.usu.ru> wrote:

> On Thursday 26 May 2005 16:15, Joerg Schilling wrote:
>
> > The problem was that you could send SCSI commands on R/O fds and fixing the
> > problem would have been to forbid sending SCSI commands on R/O fds.
>
> Unfortunately, this is not going to work. It would work only if the only app 
> that has to send SCSI commands were cdrecord. Then really, a non-setuid 
> program just would not be able to get a R/W fd, and setuid ones are assumed 
> to be trusted.

If these programs did rely on the named security bug, then these programs
were broken anyway and need to be fixed. Note that the _old_ (non ioctl based)
/dev/sg interface needed write access in order to send SCSI commands.


> The problem is that many CD audio players also send SCSI commands in order to 
> extract digital audio data. Are you proposing to make them setuid root? use a 
> well-defined setuid helper? other solution?

If these programs did ever work before, someone did break them meanwhile.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
