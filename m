Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbTDOPbY (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 11:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbTDOPbY 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 11:31:24 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:64897
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S261649AbTDOPbX 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 11:31:23 -0400
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Writing modules for 2.5
References: <yw1x7k9w9flm.fsf@zaphod.guide.suse.lists.linux.kernel>
	<p73adesxane.fsf@oldwotan.suse.de> <yw1xllyc7yoz.fsf@zaphod.guide>
	<1050406513.27745.32.camel@dhcp22.swansea.linux.org.uk>
	<yw1xbrz87x59.fsf@zaphod.guide>
	<20030415135758.C32468@flint.arm.linux.org.uk>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 15 Apr 2003 17:42:07 +0200
In-Reply-To: <20030415135758.C32468@flint.arm.linux.org.uk>
Message-ID: <yw1x7k9v938w.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> > My situation is like this: I am converting a char device driver to
> > work with linux 2.5.  In the open and close functions there are
> > MOD_INC/DEC_USECOUNT calls.  The question is what they should be
> > replaced with.  Will it be handled correctly without them?
> 
> If it's a character device driver using the struct file_operations,
> set the owner field as Alan mentioned, and remove the
> MOD_{INC,DEC}_USE_COUNT macros from the open/close methods.  This
> allows chrdev_open() (in fs/char_dev.c) to increment your module use
> count automatically.

Does this work in 2.4 also, or is the owner field used for something
else there?

-- 
Måns Rullgård
mru@users.sf.net
