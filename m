Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293416AbSCFJbP>; Wed, 6 Mar 2002 04:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293417AbSCFJbF>; Wed, 6 Mar 2002 04:31:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51208 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293416AbSCFJa5>;
	Wed, 6 Mar 2002 04:30:57 -0500
Message-ID: <3C85E168.715470C5@zip.com.au>
Date: Wed, 06 Mar 2002 01:29:12 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with 3c905B nic
In-Reply-To: <200203060842.g268gfq21995@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> 
> Mar  6 10:10:31 manta kernel: eth0: vortex_error(), status=0xe481

That's actually not an error (sorry).  It just means that the NIC's
statistics accumulators are getting full and it's time for software to
unload them.

Probably a duplex problem.  Check your statistics counters in /proc/net/dev
for errors and take a look at the mii-diag and vortex-diag output.   There
are pointers to these in Documentation/networking/vortex.txt.

-
