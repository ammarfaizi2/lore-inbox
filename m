Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbTENOel (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 10:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbTENOel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 10:34:41 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57249
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262329AbTENOek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 10:34:40 -0400
Subject: Re: Digital Rights Management - An idea (limited lease, renting,
	expiration, verification) NON HARWARE BASED.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dean McEwan <dean_mcewan@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030514135256.26073.qmail@linuxmail.org>
References: <20030514135256.26073.qmail@linuxmail.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052920142.2492.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 May 2003 14:49:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-05-14 at 14:52, Dean McEwan wrote:
> It would be set up so that files have an internal signature (ELF format might have to be
> fiddled with). It would verify itself by sending info to the creator of the contents PC OR server
> asking for verification of itself, files could be limited lease, rented, or automatically expire 
> after some time.

That way around doesnt actually work because I'll simply lie, fake the server or firewall you
(in fact any serious business firewalls all outgoing traffic from end users). If you want
to do it for internal trust and you control the systems (the useful case) you set SELinux
or RSBAC up so that all applications create files in a "non runnable" class. The only way
to transition an app is a single user application which does your key checking and other
processing then transitions the binary to "safe". I guess you also add a general rule that
writing to a file moves it back into non runnable.

One of the problems with this is interpreters. Its easy to do this with ELF binaries but
you have to extend it to scripts and that normally means more pain 8)



