Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTDOPLU (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 11:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTDOPLU 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 11:11:20 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:5567
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261651AbTDOPLT convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 11:11:19 -0400
Subject: Re: Writing modules for 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <yw1xbrz87x59.fsf@zaphod.guide>
References: <yw1x7k9w9flm.fsf@zaphod.guide.suse.lists.linux.kernel>
	 <p73adesxane.fsf@oldwotan.suse.de> <yw1xllyc7yoz.fsf@zaphod.guide>
	 <1050406513.27745.32.camel@dhcp22.swansea.linux.org.uk>
	 <yw1xbrz87x59.fsf@zaphod.guide>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1050416693.27745.44.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Apr 2003 15:24:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-15 at 13:39, Måns Rullgård wrote:
> My situation is like this: I am converting a char device driver to
> work with linux 2.5.  In the open and close functions there are
> MOD_INC/DEC_USECOUNT calls.  The question is what they should be
> replaced with.  Will it be handled correctly without them?

Remove the MOD_INC/DEC counts in the open/close path and add
owner: THIS_MODULE in the file ops, and all is happy.

