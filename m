Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965255AbWFTKCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965255AbWFTKCT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 06:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965241AbWFTKCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 06:02:19 -0400
Received: from p54AFEA14.dip.t-dialin.net ([84.175.234.20]:55941 "EHLO
	o.ww.redhat.com") by vger.kernel.org with ESMTP id S932572AbWFTKCS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 06:02:18 -0400
Date: Tue, 20 Jun 2006 12:02:09 +0200
From: Heinz Mauelshagen <mauelshagen@redhat.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: 2.6.16.20/dm: can't create more then one snapshot of an lv
Message-ID: <20060620100209.GA4566@redhat.com>
Reply-To: mauelshagen@redhat.com
References: <20060619020040.GX2059@zip.com.au> <20060620005405.GY2059@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620005405.GY2059@zip.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How many snapshots active at once ?
I guess this is a kcopyd scalability issue which needs addressing.

Regards,
Heinz    -- The LVM Guy --

On Tue, Jun 20, 2006 at 10:54:05AM +1000, CaT wrote:
> On Mon, Jun 19, 2006 at 12:00:40PM +1000, CaT wrote:
> > I am attempting to create multiple snapshots of an lv ontop of a raid-5
> > software raid device and ext3+dir_index and resize_inode for the fs.
> > The kernel is a pure 64bit compile with Debian Sarge amd64 running on
> > top of it. The kernel is monolithic and I'm using lvm2 2.01.03-5 with
> > devmapper 1.01.
> > 
> > This works under 2.6.15.7. Under 2.6.16.20 I get this:
> 
> 2.6.17 also fails.
> 
> More info: The failing kernels can deal with multiple pre-created
> snapshots but the moment I try to create one it freezes as below. Mounting
> another snapshotted volume at the time this is frozen freezes mount.
> 
> After reboot the snapshot it froze on making is available to the system
> (though the reboot fails on shutdown as it cannot unmount anything).
> 
> > # lvcreate --snapshot --size 50G --name snap-13 --permission r --verbose /dev/backups/main
> >     Setting chunksize to 16 sectors.
> >     Finding volume group "backups"
> >     Creating logical volume snap-13
> >     Archiving volume group "backups" metadata.
> >     Creating volume group backup "/etc/lvm/backup/backups"
> >     Found volume group "backups"
> >     Loading backups-snap--13
> >     Zeroing start of logical volume "snap-13"
> >     Found volume group "backups"
> >     Removing backups-snap--13
> >     Found volume group "backups"
> >     Found volume group "backups"
> >     Found volume group "backups"
> >     Loading backups-main-real
> >     Loading backups-snap--12-cow
> >     Loading backups-snap--12
> > *freeze*
> 
> -- 
>     "To the extent that we overreact, we proffer the terrorists the
>     greatest tribute."
>     	- High Court Judge Michael Kirby
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Red Hat GmbH
Consulting Development Engineer                   Am Sonnenhang 11
Storage Development                               56242 Marienrachdorf
                                                  Germany
Mauelshagen@RedHat.com                            PHONE +49  171 7803392
                                                  FAX   +49 2626 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
