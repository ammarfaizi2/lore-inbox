Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWJGSTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWJGSTm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 14:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWJGSTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 14:19:42 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:21450 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1751429AbWJGSTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 14:19:42 -0400
Date: Sat, 7 Oct 2006 20:19:36 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Devesh Sharma <devesh28@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling dependent module
Message-ID: <20061007181936.GA5937@uranus.ravnborg.org>
References: <309a667c0610070512y47718898i4a664ef6cce7c312@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <309a667c0610070512y47718898i4a664ef6cce7c312@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2006 at 05:42:47PM +0530, Devesh Sharma wrote:
> Hello all,
> 
> I have a situation where, I have one parent module in ../hello/
> directory which exports one symbol (g_my_export). I have a dependent
> module in ../hello1/ directory. Both have it's own makefiles.
> Compiling of parent module (hello.ko) is fine, but during compilation
> of dependent module (hello1.ko) I see a warning that g_my_export is
> undefined.
> 
> On the other hand when I do depmod -a and modprobe, dependent module
> inserts successfully in kernel.
> 
> I want to remove compile time warning. What should I do?

Compile both module in same go.
See Documentation/kbuild/modules.txt for a description.

In short create a kbuild file that points to both modules
so kbuild knows about both modules when it builds them.

	Sam
