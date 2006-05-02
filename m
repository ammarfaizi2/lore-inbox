Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbWEBXjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWEBXjW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 19:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWEBXjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 19:39:22 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:42631 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S964988AbWEBXjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 19:39:21 -0400
In-Reply-To: <200605021259.24157.arnd@arndb.de>
References: <20060429232812.825714000@localhost.localdomain> <200605020150.14152.arnd@arndb.de> <1900A234-BE31-4292-87E1-5C02F12A440D@kernel.crashing.org> <200605021259.24157.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <801072F8-7701-4BD7-81FB-A8C1AA534C2E@kernel.crashing.org>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specific files
Date: Wed, 3 May 2006 01:38:56 +0200
To: Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Is there any reason the driver wouldn't build and/or run on other
>> platforms?  If so, fix it.  If not, just make it
>>
>>         depends on PCI
>
> Well, it could run on other platforms, except:
>
> - it requires a few properties in the device tree (local-mac-address,
>   firmware), so it should also depend on PPC

The portions of code that require OF should have appropriate #ifdef  
guards.

> - It's not actually PCI at all, but on an internal bus that has
>   something close enough to a PCI config space.

Our emulation should be good enough; if not, holler (off-list).


Segher

