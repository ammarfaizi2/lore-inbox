Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbTDCRPC 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 12:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261513AbTDCRPC 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 12:15:02 -0500
Received: from [207.61.129.108] ([207.61.129.108]:6849 "EHLO mail.datawire.net")
	by vger.kernel.org with ESMTP id S261510AbTDCROx 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 12:14:53 -0500
From: Shawn Starr <shawn.starr@datawire.net>
Organization: Datawire Communication Networks Inc.
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: acpi spinlock breakage
Date: Thu, 3 Apr 2003 12:26:12 -0500
User-Agent: KMail/1.5
Cc: Dave Jones <davej@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304031226.12300.shawn.starr@datawire.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Confirmed :-(

Trying to find out what broke, but none of those members are listed even 
inside osl.c (perhaps a header down the line).

>List:     linux-kernel
>Subject:  acpi spinlock breakage
From:     Dave Jones <davej () codemonkey ! org ! uk>
>Date:     2003-04-02 16:21:26

>osl stuff looks really borked in current 2.5-bk ..

>drivers/acpi/osl.c: In function `acpi_os_acquire_lock':
>drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
>drivers/acpi/osl.c:739: request for member `magic' in something not a 
>structure or union
>drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
>drivers/acpi/osl.c:739: request for member `lock' in something not a 
>structure or union
>drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
>drivers/acpi/osl.c:739: request for member `babble' in something not a 
>structure or union
>drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
>drivers/acpi/osl.c:739: request for member `module' in something not a 
>structure or union
>drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
>drivers/acpi/osl.c:739: request for member `owner' in something not a 
>structure or union
>drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
>drivers/acpi/osl.c:739: request for member `oline' in something not a 
>structure or union
>drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
>drivers/acpi/osl.c:739: request for member `babble' in something not a 
>structure or union
>drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
>drivers/acpi/osl.c:739: request for member `lock' in something not a 
>structure or union
>drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
>drivers/acpi/osl.c:739: request for member `owner' in something not a 
>structure or union
>drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
>drivers/acpi/osl.c:739: request for member `oline' in something not a 
>structure or union
>...

-- 
Shawn Starr
UNIX Systems Administrator, Operations
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008
shawn.starr@datawire.net
"The power to Transact" - http://www.datawire.net

