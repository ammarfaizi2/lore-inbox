Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293385AbSCECAv>; Mon, 4 Mar 2002 21:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293367AbSCECAg>; Mon, 4 Mar 2002 21:00:36 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:38410 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293299AbSCEB6r>;
	Mon, 4 Mar 2002 20:58:47 -0500
Date: Mon, 4 Mar 2002 17:51:14 -0800
From: Greg KH <greg@kroah.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of mp_bus_id_to_node array in 2.5.6-pre2
Message-ID: <20020305015114.GC6139@kroah.com>
In-Reply-To: <20020305010910.GA6139@kroah.com> <256650000.1015292871@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <256650000.1015292871@flay>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 04 Feb 2002 22:57:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 05:47:51PM -0800, Martin J. Bligh wrote:
> Please don't remove this! This was preparatory work I did to enable
> me to use PCI buses on nodes > 0 on NUMA-Q. The rest of the code
> isn't in 2.5 yet (hence you can't see where it's used ;-) ) but the patches
> to use it are now in 2.4, and I will submit them to 2.5 very shortly ....
> (guess I'd better hurry up ;-) )

Ah, that makes sense.  Please don't apply this patch then.

The reason I'm looking at this code is because I now have access to a
i386 box that needs an increased value for MAX_MP_BUSSES to boot
properly.  This is because of the PCI hotplug functionality that this
box has for it's extra PCI busses.

I'm trying to update James Cleverdon's patch that dynamically determined
the proper value for MAX_MP_BUSSES at init to the latest kernel, but
I'll stick with 2.4 for now until you get the NUMA PCI patch into 2.5.

thanks,

greg k-h
