Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVCYWwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVCYWwQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVCYWvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:51:46 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:22441 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261845AbVCYWtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:49:20 -0500
Subject: Re: [PATCH scsi-misc-2.6 08/08] scsi: fix hot unplug sequence
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4244860E.5090800@gmail.com>
References: <20050323021335.960F95F8@htj.dyndns.org>
	 <20050323021335.4682C732@htj.dyndns.org>
	 <1111550882.5520.93.camel@mulgrave> <4240F5A9.80205@gmail.com>
	 <20050323071920.GJ24105@suse.de> <1111591213.5441.19.camel@mulgrave>
	 <20050323152550.GB16149@suse.de> <1111711558.5612.52.camel@mulgrave>
	 <20050325031511.GA22114@htj.dyndns.org> <1111726965.5612.62.camel@mulgrave>
	 <20050325053842.GA24499@htj.dyndns.org> <1111778388.5692.38.camel@mulgrave>
	  <4244860E.5090800@gmail.com>
Content-Type: text/plain
Date: Fri, 25 Mar 2005 16:49:10 -0600
Message-Id: <1111790950.5692.63.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-26 at 06:43 +0900, Tejun Heo wrote:
>  1. Allocate scsi_request and request (two are linked)

This can't be done because the scsi_cmnd's are allocated specially (slab
with reserve pool).

James


