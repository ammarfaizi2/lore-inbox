Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbVBYOR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbVBYOR4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 09:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbVBYOR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 09:17:56 -0500
Received: from moutng.kundenserver.de ([212.227.126.185]:23537 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262703AbVBYORy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 09:17:54 -0500
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: how to capture kernel panics
Date: Fri, 25 Feb 2005 15:17:56 +0100
User-Agent: KMail/1.7.1
Cc: "shabanip" <shabanip@avapajoohesh.com>
References: <52765.69.93.110.242.1109288148.squirrel@69.93.110.242>
In-Reply-To: <52765.69.93.110.242.1109288148.squirrel@69.93.110.242>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502251517.56254.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shabanip wrote:
> is there any way to capture and log kernel panics on disk or ...?

In former times, the Linux kernel tried to sync in the panic function. (If 
the panic did not happen in interrupt context) Unfortunately this had 
severe side effects in cases where the panic was triggered by file system 
block device code or any other part which is necessary for syncing. In most 
cases the call trace never made it onto disk anyway. So currently the 
kernel does not support saving a panic.

Apart from using a serial console, you might have a look at several 
kexec/kdump/lkcd tools where people are working on being able to dump the 
memory of a paniced kernel.

cheers

Christian
