Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264799AbUEPT3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264799AbUEPT3O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 15:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264801AbUEPT3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 15:29:14 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:38031 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264799AbUEPT3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 15:29:13 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Jan De Luyck <lkml@kcore.org>
Subject: Re: [2.6.6] Synaptics driver is 'jumpy'
Date: Sun, 16 May 2004 14:29:10 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200405161222.48581.lkml@kcore.org> <200405161218.37521.dtor_core@ameritech.net> <200405162106.29858.lkml@kcore.org>
In-Reply-To: <200405162106.29858.lkml@kcore.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200405161429.10448.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 May 2004 02:06 pm, Jan De Luyck wrote:
> On Sunday 16 May 2004 19:18, Dmitry Torokhov wrote:
> > Hmm.. there was no changes to PS/2 processing between 2.6.5 and 2.6.6
> > except for some Logitech tweaking, but it should not affect Synaptics
> > handling in any way...
> >
> > Could you check if you still have DMA enabled on your disks, check your
> > time source (TSC, ACPI PM timer, etc) and probably boot with acpi off?
> >
> > Thank you.
> 
> Dmitry,
> 
> Booting with acpi=off fixes the problem, although I'm curious to what the
> problem actually is.
> 
> I've attached the dmesgs from 2.6.6, 2.6.5, and 2.6.6 with acpi=off.
> 
> There is a line that says "Invalid control registers" that I wonder where it
> comes from, but you might see something more here than I do.
> 

It comes from speedstep-centrino module, could you please try booting with ACPI
but without speedstep-centrino loaded? Also, does it help if you do not compile/
load ACPI battery module?

-- 
Dmitry
