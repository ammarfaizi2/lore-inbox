Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319114AbSIJNKu>; Tue, 10 Sep 2002 09:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319113AbSIJNKu>; Tue, 10 Sep 2002 09:10:50 -0400
Received: from gate.in-addr.de ([212.8.193.158]:31763 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S319111AbSIJNKs>;
	Tue, 10 Sep 2002 09:10:48 -0400
Date: Tue, 10 Sep 2002 15:04:27 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
Message-ID: <20020910130427.GP2992@marowsky-bree.de>
References: <patmans@us.ibm.com> <200209091734.g89HY5p11796@localhost.localdomain> <20020909170847.A24352@eng2.beaverton.ibm.com> <10209100055.ZM65139@classic.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10209100055.ZM65139@classic.engr.sgi.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-09-10T00:55:58,
   Jeremy Higdon <jeremy@classic.engr.sgi.com> said:

> Is there any plan to do something for hardware RAIDs in which two different
> RAID controllers can get to the same logical unit, but you pay a performance
> penalty when you access the lun via both controllers? 

This is implemented in the md multipath patch in 2.4; it distinguishes between
"active" and "spare" paths.

The LVM1 patch also does this by having priorities for each path and only
going to the next priority group if all paths in the current one have failed,
which IMHO is slightly over the top but there is always someone who might need
it ;-)

This functionality is a generic requirement IMHO.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

