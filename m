Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291616AbSBAJIE>; Fri, 1 Feb 2002 04:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291618AbSBAJHy>; Fri, 1 Feb 2002 04:07:54 -0500
Received: from p3EE02CD7.dip.t-dialin.net ([62.224.44.215]:60678 "EHLO
	srv.sistina.com") by vger.kernel.org with ESMTP id <S291616AbSBAJHl>;
	Fri, 1 Feb 2002 04:07:41 -0500
Date: Fri, 1 Feb 2002 10:03:03 +0100
From: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] LVM reimplementation ready for beta testing
Message-ID: <20020201100303.A14415@sistina.com>
Reply-To: mauelshagen@sistina.com
In-Reply-To: <20020130202254.A7364@fib011235813.fsnet.co.uk> <20020131010119.GB858@ufies.org> <20020131134533.A10295@sistina.com> <20020131134225.B32321@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020131134225.B32321@havoc.gtf.org>; from garzik@havoc.gtf.org on Thu, Jan 31, 2002 at 01:42:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 01:42:25PM -0500, Jeff Garzik wrote:
> On Thu, Jan 31, 2002 at 01:45:33PM +0100, Heinz J . Mauelshagen wrote:
> > LVM2 and the device-mapper are GPL/LGPL.
> 
> Could you clarify the meaning of "GPL/LGPL"?  Are certain parts GPL and
> other parts LGPL?  If so, which parts?

The LVM2 sofware no longer uses a particular driver which is just
usable for its own purpose.
It rather accesses a different, so-called 'device-mapper' driver, which
implements a generic volume management service for the Linux kernel by
supporting arbitray mappings of address ranges to underlying block devices.
Because this is a generic service rather than an application within the kernel,
it is open to be used by multiple LVM implementations (for eg. EVMS could be
ported to use it :-)

The device-mapper driver is under the GPL and our Beta1 release dated Wednesday,
which included the LVM2 tools as well, supports 2.4 kernels. We are aiming to
get it integrated into the stock kernel and are implementing the necessary
changes (bio interface) for 2.5 now.
We released a device-mapper library (implements a generic API for the
device-mapper) which is under the LGPL with it.

The LVM2 tools have a library with routines to for eg. access the
device-mapper library, deal with LVM metadata (VGDA), support different
metadata formats and offer configuration file support which is under the
LGPL as well.
The tools themselves (vgcreate, lvcreate, ...) are under the GPL.

IOW:

GPL				LGPL
-----------------------------   ------------------------------
LVM2 tools			LVM2 library
device-mapper driver		device-mapper library

> 
> 	jeff
> 
> 

-- 

Regards,
Heinz    -- The LVM Guy --

*** Software bugs are stupid.
    Nevertheless it needs not so stupid people to solve them ***

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@Sistina.com                           +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
