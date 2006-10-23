Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbWJWTDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbWJWTDo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWJWTDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:03:44 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:63906 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S965064AbWJWTDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:03:43 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Michael Holzheu <holzheu@de.ibm.com>
Subject: Re: How to document dimension units for virtual files?
Date: Mon, 23 Oct 2006 21:03:32 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
References: <20061023143254.496420f7.holzheu@de.ibm.com>
In-Reply-To: <20061023143254.496420f7.holzheu@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610232103.33710.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Monday, 23. October 2006 14:32, Michael Holzheu wrote:
> The question is how to provide the dimension unit information to
> the user.
> 
> I see three possibilites:
> 
> 1. Write dimension unit into the output string (e.g. "476362365 kB"),
> which makes parsing a bit more complicated.
> 
> 2. Encode dimension unit into filename (e.g. onlinetime_ms or memory_kb)

This is the recommended one.
- simple to implement and understand on both sides

- if you change units, you notice breaking userspace immediately
  and can even notice it being used in closed source tools 
  with a simple strace

- no parsing involved, as the author of the user space tool 
  usually assumes the unit implicitly (like "programming by contract", where
  the "contract" is the filename, which is quite easy to check for.

- you can keep a legacy interface with neglible effort and code wastage

- many advantages I forgot :-)

> 3. Document dimension unit somewhere. In that case we need some central
> place to provide such information. E.g. in the Documentation directory of
> the linux kernel.

Regards

Ingo Oeser
