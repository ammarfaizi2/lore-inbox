Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269696AbTGOVIl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 17:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269698AbTGOVIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 17:08:41 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:13969 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269696AbTGOVHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 17:07:49 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Date: Tue, 15 Jul 2003 16:14:31 -0500
User-Agent: KMail/1.5
References: <20030711155613.GC2210@gtf.org> <20030715000331.GB904@matchmail.com> <20030715170804.GA1089@win.tue.nl>
In-Reply-To: <20030715170804.GA1089@win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307151614.31863.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 July 2003 12:08, Andries Brouwer wrote:
> On Mon, Jul 14, 2003 at 05:03:31PM -0700, Mike Fedyk wrote:
> > So, will the DOS partition make it up to 2TB?  If so, then we won't have
> > a problem until we have larger than 2TB drives
>
> Yes, DOS partition table works up to 2^32 sectors, and with
> 2^9-byte sectors that is 2 TiB.
>
> People are encountering that limit already. We need something
> better, either use some existing scheme, or invent something.
>
> Andries

I would suggest the GPT format. It was originally designed for use with the 
IA-64 EFI firmware, but works just fine on any other architecture. It's 
64-bit, so no 2 TB limitations. It also avoids the primary vs. extended vs. 
logical partition weirdness that DOS has.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

