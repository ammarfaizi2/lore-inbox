Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267102AbSLDVhV>; Wed, 4 Dec 2002 16:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267106AbSLDVhV>; Wed, 4 Dec 2002 16:37:21 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:27143 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267102AbSLDVhU>; Wed, 4 Dec 2002 16:37:20 -0500
Date: Wed, 4 Dec 2002 22:44:48 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Shawn Starr <shawn.starr@datawire.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.50, ACPI] link error
In-Reply-To: <200212041630.40446.shawn.starr@datawire.net>
Message-ID: <Pine.LNX.4.44.0212042239590.2113-100000@serv>
References: <200212041605.11935.shawn.starr@datawire.net>
 <Pine.LNX.4.44.0212042223270.2109-100000@serv> <200212041630.40446.shawn.starr@datawire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 4 Dec 2002, Shawn Starr wrote:

> ACPI_SLEEP should only be required if the user selects SOFTWARE_SUSPEND. 
> Otherwise if the user selects only ACPI_SLEEP then they don't get software 
> suspend mode (S3).
> 
> Then problem is, I can't figure out how to get Kconfig to do this ;-(

This should do it:

config ACPI_SLEEP
	bool "Sleep States" if !SOFTWARE_SUSPEND
	default SOFTWARE_SUSPEND
	depends on X86

bye, Roman

