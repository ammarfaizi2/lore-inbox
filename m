Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267410AbSKPX45>; Sat, 16 Nov 2002 18:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267412AbSKPX45>; Sat, 16 Nov 2002 18:56:57 -0500
Received: from tapu.f00f.org ([66.60.186.129]:24262 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S267410AbSKPX44>;
	Sat, 16 Nov 2002 18:56:56 -0500
Date: Sat, 16 Nov 2002 16:03:54 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Arun Sharma <arun.sharma@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reserving "special" port numbers in the kernel ?
Message-ID: <20021117000354.GA443@tapu.f00f.org>
References: <uel9mbcyi.fsf@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uel9mbcyi.fsf@unix-os.sc.intel.com>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 04:00:37PM -0800, Arun Sharma wrote:

> One of the Intel server platforms has a magic port number (623) that
> it uses for remote server management. However, neither the kernel
> nor glibc are aware of this special port.

Odd.

charon:~% grep -c 623 /etc/services
0

rfc1700:

[...]

WELL KNOWN PORT NUMBERS

The Well Known Ports are controlled and assigned by the IANA and on
most systems can only be used by system (or root) processes or by
programs executed by privileged users.

[...]

npmp-gui        611/tcp    npmp-gui
npmp-gui        611/udp    npmp-gui
#                          John Barnes <jbarnes@crl.com>
ginad           634/tcp    ginad
ginad           634/udp    ginad


I don't see port 623 in there.  Where is this documented?

> As a result, when someone requests a privileged port using
> bindresvport(3), they may get this port back and bad things happen.

Indeed.   It seems like they should be able to get this port.

What bad things happen?

> Has anyone run into this or similar problems before ? Thoughts on
> what's the right place to handle this issue ?

User-land.  Fix broken applications.



  --cw
