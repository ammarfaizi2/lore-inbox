Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTKNKeV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 05:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTKNKeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 05:34:21 -0500
Received: from smtp1.wanadoo.fr ([193.252.22.30]:23140 "EHLO
	mwinf0104.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262328AbTKNKeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 05:34:20 -0500
Date: Fri, 14 Nov 2003 11:34:03 +0100
To: Andrew Morton <akpm@osdl.org>, Mary Edie Meredith <maryedie@osdl.org>,
       piggin@cyberone.com.au, linux-kernel@vger.kernel.org, jenny@osdl.org
Subject: Re: Nick's scheduler v18
Message-ID: <20031114103403.GA5177@iliana>
References: <3FAFC8C6.8010709@cyberone.com.au> <1068746827.1750.1358.camel@ibm-e.pdx.osdl.net> <20031113113906.65431b18.akpm@osdl.org> <20031113222751.GJ2014@mis-mike-wstn.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20031113222751.GJ2014@mis-mike-wstn.matchmail.com>
User-Agent: Mutt/1.5.4i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 02:27:51PM -0800, Mike Fedyk wrote:
> On Thu, Nov 13, 2003 at 11:39:06AM -0800, Andrew Morton wrote:
> > What filesystem was being used?
> > 
> > If it was ext2 then perhaps you hit the recently-fixed block allocator
> > race.  That fix was merged after test9.  Please check the kernel logs for
> > any filesystem error messages.
> > 
> > Also, please retry the run, see if it is repeatable.
> 
> Did that hit ext3 also?  ISTR, getting some "access beyond end of device"
> while running ext3.

BTW, i did encounter some problem with amiga partitions which had some
bad values due to a bug in libparted now fixed. The head size was
counted double or something such, which resulted in accesses beyon the
end of the device. It has a funny effect though. The box would freeze,
and the IDE led would flash in 1 second intervals. Not sure it is the
expected behavior. This is with a 2.4.22 kernel, both on x86 and ppc.

Friendly,

Sven Luther
