Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275044AbRJCEsg>; Wed, 3 Oct 2001 00:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275338AbRJCEs0>; Wed, 3 Oct 2001 00:48:26 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:2108 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S275044AbRJCEsU>; Wed, 3 Oct 2001 00:48:20 -0400
Subject: Re: Modutils 2.5 change, start running this command now
From: Robert Love <rml@tech9.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <31135.1002083784@kao2.melbourne.sgi.com>
In-Reply-To: <31135.1002083784@kao2.melbourne.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.30.08.08 (Preview Release)
Date: 03 Oct 2001 00:48:50 -0400
Message-Id: <1002084533.858.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-10-03 at 00:36, Keith Owens wrote:
> In current modutils, a module that does not export symbols and does not
> say EXPORT_NO_SYMBOLS defaults to exporting all symbols.  This is a
> hangover from kernel 2.0 and will be removed when modutils 2.5 appears,
> shortly after the kernel 2.5 branch is created.

This is an excellent move.

> Starting with modutils 2.5, modules must explicitly say what their
> intention is for symbols.  That will break a lot of existing modules.
> The command below lists the modules on your system that will be
> affected.  All code maintainers need to run this against their 2.4
> modules and do one of two things.  Either export the required symbols
> (remember to add the .o file to export-objs in the Makefile) or add
> EXPORT_NO_SYMBOLS; somewhere in the module (no change to Makefile).

Once 2.5 starts, I'll be happy to go over modules with this script and
fix up stuff that is unmaintained.

>  objdump -h `modprobe -l` | \
>  awk '/file format/{file = $1}/__ksymtab/{file = ""}/\.comment/ && file != "" {print file}'

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

