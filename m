Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWEWMwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWEWMwn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 08:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWEWMwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 08:52:43 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:31171 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751338AbWEWMwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 08:52:42 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: i386 Kconfig options out of order 
In-reply-to: Your message of "Tue, 23 May 2006 11:30:39 +0200."
             <Pine.LNX.4.64.0605231127550.17704@scrub.home> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 May 2006 22:51:13 +1000
Message-ID: <8522.1148388673@ocs3>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel (on Tue, 23 May 2006 11:30:39 +0200 (CEST)) wrote:
>Hi,
>
>On Tue, 23 May 2006, Keith Owens wrote:
>
>> Options NUMA and EFI in arch/i386/Kconfig depend on ACPI but they
>> appear before the ACPI option.  make oldconfig with no initial setting
>> for CONFIG_ACPI will prompt for these options, but if you then say No
>> to CONFIG_ACPI the options will silently be turned off.
>
>That's the normal behaviour.

Fair enough.  I was switching between configs with ACPI=y and ACPI=n,
every time I editted .config to remove the current ACPI setting and ran
oldconfig to insert the new setting, I got prompted for these extra
options.  Forward dependencies in configs, yuck.

