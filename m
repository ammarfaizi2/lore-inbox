Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWCUXBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWCUXBp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 18:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWCUXBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 18:01:45 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:17074 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932342AbWCUXBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 18:01:44 -0500
Subject: Re: Question: where should the SCSI driver place MODE_SENSE data ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <9738BCBE884FDB42801FAD8A7769C265142114@NAMAIL1.ad.lsil.com>
References: <9738BCBE884FDB42801FAD8A7769C265142114@NAMAIL1.ad.lsil.com>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 17:01:39 -0600
Message-Id: <1142982099.3428.37.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 09:44 -0700, Ju, Seokmann wrote:
> In the 2.6 (2.6.9 and scsi-misc in git) kernel, MODE_SENSE SCSI command
> packet (scsi_cmnd) carries following entries with unexpectedly small in
> size.
> - request_bufflen
> - bufflen
> 
> Especially for MODE SENSE with page code 8 (caching page), driver has
> minumum 12 Bytes MODE_SENSE data to deliver besides 'mode parameter
> header' and 'block descriptors'.
> When I dump those entries, they both are 4 Bytes in size.
> To me, it seems like that SCSI mid layer allocated 512 Bytes for
> MODE_SENSE data buffer, but the buffer length passed down to LLD
> incorrectly.

I don't understand the question.  Are you asking why
sd_read_write_protect_flag and sd_read_cache_type operate in the way
they do?  i.e. header first then actual data.

James


