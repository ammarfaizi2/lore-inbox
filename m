Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293603AbSCKWup>; Mon, 11 Mar 2002 17:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293657AbSCKWub>; Mon, 11 Mar 2002 17:50:31 -0500
Received: from fungus.teststation.com ([212.32.186.211]:37137 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S293701AbSCKWtR>; Mon, 11 Mar 2002 17:49:17 -0500
Date: Mon, 11 Mar 2002 23:49:13 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.teststation.com
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: smbfs and failed nls translations
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7CD2@orsmsx111.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0203112341390.7285-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Grover, Andrew wrote:

> Hi, apparently my smbfs mounts have had failed nls translations, but I
> didn't know it -- never saw any warnings. So when I upgraded to 2.5.6 that
> included this patch, the filenames on my samba mounts all turned into
> "x00:x00..." etc. ;-)

smbmount from certain samba versions always negotiate unicode support.
smbfs should probably turn on it's internal unicode support when it sees
that, but right now it doesn't.

samba 2.2.1 is known to error this way, 2.2.3 should be fixed.

One workaround should be to pass codepage=unicode or to specify unicode as
the CONFIG_SMB_NLS_DEFAULT. Another to upgrade samba.

Please post the exact output of a few filenames as well as the expected
names if none of the above helps.

/Urban

