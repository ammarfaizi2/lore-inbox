Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319673AbSIMPhb>; Fri, 13 Sep 2002 11:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319674AbSIMPhb>; Fri, 13 Sep 2002 11:37:31 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:64783
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319673AbSIMPhb>; Fri, 13 Sep 2002 11:37:31 -0400
Date: Fri, 13 Sep 2002 08:40:24 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: Lost Interrupts, if you have them ...
Message-ID: <Pine.LNX.4.10.10209130833140.29877-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you have this problem w/ the -ac patches or any other version, I want
to know.  Please contact offline as I will ask you to send a list of
information.  There is a lot of noise and I am searching for the signal
part of the issue.

I can only find two settings which can cause the issue predictable.
hdparm -c2 or -c3 /dev/hdX

I can not reproduce the lost interrupts at some of the reported rates
recently.  I can produce them under certain situations, but not at a
predicatble rate.  This is not a simple race to find.

It is looking like a possible OS v/s device race for interrupt delivery.
More likely the device issues the interrupt w/ out the handler being
armed.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

