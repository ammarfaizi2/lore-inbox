Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVATWED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVATWED (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 17:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVATWEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 17:04:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54227 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262083AbVATWC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 17:02:56 -0500
Date: Thu, 20 Jan 2005 22:02:52 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Norbert van Nobelen <Norbert@edusupport.nl>
Cc: "Trever L. Adams" <tadams-lists@myrealbox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: LVM2
Message-ID: <20050120220252.GA14097@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Norbert van Nobelen <Norbert@edusupport.nl>,
	"Trever L. Adams" <tadams-lists@myrealbox.com>,
	linux-kernel@vger.kernel.org
References: <1106250687.3413.6.camel@localhost.localdomain> <200501202240.02951.Norbert@edusupport.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501202240.02951.Norbert@edusupport.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 10:40:02PM +0100, Norbert van Nobelen wrote:
> A logical volume in LVM will not handle more than 2TB. You can tie together 
> the LVs in a volume group, thus going over the 2TB limit. 

Confused over terminology?
Tie PVs together to form a VG, then divide VG up into LVs.

Size limit depends on metadata format and the kernel: old LVM1 format has 
lower size limits - see the vgcreate man page.

New LVM2 metadata format relaxes those limits and lets you have LVs > 2TB
with a 2.6 kernel.

Alasdair
-- 
agk@redhat.com
