Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263339AbTE0EfP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 00:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbTE0EfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 00:35:15 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:55825 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263339AbTE0EfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 00:35:14 -0400
Date: Tue, 27 May 2003 06:48:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-bk19 "make" messages much less informative
Message-ID: <20030527044825.GA1055@mars.ravnborg.org>
Mail-Followup-To: "Adam J. Richter" <adam@yggdrasil.com>,
	linux-kernel@vger.kernel.org
References: <200305262223.h4QMN5D12796@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305262223.h4QMN5D12796@adam.yggdrasil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 03:23:05PM -0700, Adam J. Richter wrote:
> 	Also, I used to be able to copy and paste the gcc command
> for compiling a particular file when I'm trying to get rid of compiler
> errors.

The easy way to handle this is actually to ask kbuild to compile the
file in question.
Example:
$ make arch/i386/kernel/acpi/boot.o

This wil perfectly fine compile boot.c - no need to hassle with copying
long gcc command lines.

A shorthand exists for compiling all built-in files in a directory
as well. Very useful when working on a subsystem.
Assuming ext2 is built-in try out:
$ make fs/ext2/

And as already pointed out, the easy way to enable to verbose
output is to use:
$ make V=1

	Sam
