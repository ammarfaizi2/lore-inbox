Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTEENcw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 09:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbTEENcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 09:32:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59065 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262202AbTEENcr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 09:32:47 -0400
Date: Mon, 5 May 2003 14:45:16 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030505134516.GB10374@parcelfarce.linux.theplanet.co.uk>
References: <Pine.SGI.4.10.10305051745290.8200163-100000@Sky.inp.nsk.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.10.10305051745290.8200163-100000@Sky.inp.nsk.su>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 08:30:38PM +0700, Dmitry A. Fedorov wrote:
> I use the following calls:
> 
> sys_mknod
> sys_chown
> sys_umask
> sys_unlink
> 
> for creating/deleting /dev entries dynamically on driver
> loading/unloading. It allows me to acquire dynamic major
> number without devfs and external utility of any kind.
> And there is no risk of intersection with statically assigned major
> numbers, as it is for many others third-party sources.

*yuck*

Do that from modprobe.  "No external utility" is not a virtue, especially
when said utility is a trivial shell script.
