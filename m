Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932698AbWBUETS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbWBUETS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 23:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbWBUETS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 23:19:18 -0500
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:11424 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932698AbWBUETS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 23:19:18 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 20 Feb 2006 23:19:14 -0500
User-Agent: KMail/1.9.1
Cc: Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <slrndvkp1m.326.andreashappe@localhost.localdomain> <200602211257.29161.ncunningham@cyclades.com>
In-Reply-To: <200602211257.29161.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602202319.15018.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 21:57, Nigel Cunningham wrote:
> For the record, my thinking went: swsusp uses n (12?) bytes of meta data for 
> every page you save, where as using bitmaps makes that much closer to a 
> constant value (a small variable amount for recording where the image will be 
> stored in extents). 12 bytes per page is 3MB/1GB. If swsusp was to add 
> support for multiple swap partitions or writing to files, those requirements 
> might be closer to 5MB/GB. 

5MB/GB amounts to 0.5% overhead, I don't think you should be concerned here.
Much more important IMHO is that IIRC swsusp requires to be able to free 1/2
of the physical memory whuch is hard on low memory boxes.

-- 
Dmitry
