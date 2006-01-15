Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWAOTta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWAOTta (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 14:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWAOTta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 14:49:30 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:35769 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932116AbWAOTt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 14:49:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=cP+PZspw+Rz1p+TdNnEO985XkqRCswVil5jrTteZw1euQFqm3rzgQ3PLmfMDiVmaFe8hU8XLPu24O50TJjsgKm7OLxDEFhB0CR/XNFkv4N2ctN/h0C3bKZM1fQgu0Toe2BEI1s6KaLCNmPLf13IsiK6xjjpWDK5p8nAlKFCb96M=
Subject: Re: string to inode conversion
From: "pablo.ferlop@gmail.com" <pablo.ferlop@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1137353054.3230.8.camel@laptopd505.fenrus.org>
References: <1137351430.11284.2.camel@localhost.localdomain>
	 <1137353054.3230.8.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 15 Jan 2006 20:49:36 +0100
Message-Id: <1137354577.11981.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This should be in kernel space, in the context of system calls.

Basically I'm trying to learn how sys_open() goes from char *filename to
a struct inode. I know (or think) that sys_open() doesn't actually use a
struct inode, but I wonder how that would go.

Thanks


El dom, 15-01-2006 a las 20:24 +0100, Arjan van de Ven escribió:
> On Sun, 2006-01-15 at 19:57 +0100, pablo.ferlop@gmail.com wrote:
> > Hi
> > 
> > I was wondering how I can get from a string with a path like "/home" or
> > "/lib/libc-2.3.5.so" a struct inode.
> 
> which namespace do you want this in? The init one? or the one from the
> user? (most traditional linux distributions only have one namespace, but
> now that COW namespaces are merged I expect distros to start
> experimenting with per user /tmp, or per-daemon data etc etc)
> 
> This is not a trivial thing... you need a "context" into which you can
> ask that question (basically a process)
> 

