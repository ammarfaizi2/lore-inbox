Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292966AbSBVUN4>; Fri, 22 Feb 2002 15:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292976AbSBVUNe>; Fri, 22 Feb 2002 15:13:34 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:44048 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S292966AbSBVUN1>;
	Fri, 22 Feb 2002 15:13:27 -0500
Date: Fri, 22 Feb 2002 12:07:50 -0800
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
Message-ID: <20020222200750.GE9558@kroah.com>
In-Reply-To: <3C76A053.55A32E77@mandrakesoft.com> <20020221215503.M1666-100000@gerard>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020221215503.M1666-100000@gerard>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 25 Jan 2002 16:56:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2002 at 10:01:14PM +0100, Gérard Roudier wrote:
> 
> I have investigated it, but it didn't seem to allow the boot order set by
> user in sym53c8xx HBA NVRAMs to be applied, breaking as a result all
> systems depending on it. Since it is transparently handled by the
> sym53c8xx driver and just behaves _as_ user expects, my guess is that
> numerous users may just have their system relying on it.

But as Jeff noted, it is _required_ for PCI hotplug functionality.
Because allmost all of the SCSI drivers are not using this over 2 year
old interface, they will not work properly on large machines that now
support PCI hotplug.  Much to my dismay.

Init order works off of PCI probing order.  If the network people can
handle this, the SCSI people can :)

> Propose a kernel API that does not break more features that it adds and I
> will be glad to use it.

Huh?  This is not a new API.  What does it break for you?

thanks,

greg k-h
