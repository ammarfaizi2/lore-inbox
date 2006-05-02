Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWEBK7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWEBK7g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 06:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWEBK7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 06:59:36 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:16627 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932189AbWEBK7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 06:59:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specific files
Date: Tue, 2 May 2006 12:59:23 +0200
User-Agent: KMail/1.9.1
Cc: Segher Boessenkool <segher@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
References: <20060429232812.825714000@localhost.localdomain> <200605020150.14152.arnd@arndb.de> <1900A234-BE31-4292-87E1-5C02F12A440D@kernel.crashing.org>
In-Reply-To: <1900A234-BE31-4292-87E1-5C02F12A440D@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200605021259.24157.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 02:06, Segher Boessenkool wrote:
> Is there any reason the driver wouldn't build and/or run on other
> platforms?  If so, fix it.  If not, just make it
> 
>         depends on PCI

Well, it could run on other platforms, except:

- it requires a few properties in the device tree (local-mac-address,
  firmware), so it should also depend on PPC
- It's not actually PCI at all, but on an internal bus that has
  something close enough to a PCI config space.

	Arnd <><
