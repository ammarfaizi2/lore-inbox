Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVCAWSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVCAWSE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 17:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVCAWSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 17:18:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20885 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262088AbVCAWR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 17:17:59 -0500
Date: Tue, 1 Mar 2005 22:17:53 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: dougg@torque.net, Adrian Bunk <bunk@stusta.de>,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] SCSI: possible cleanups
Message-ID: <20050301221753.GA5742@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Luben Tuikov <luben_tuikov@adaptec.com>, dougg@torque.net,
	Adrian Bunk <bunk@stusta.de>, James.Bottomley@SteelEye.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20050228213159.GO4021@stusta.de> <4224245E.6090503@torque.net> <42247EF0.9000404@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42247EF0.9000404@adaptec.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 09:40:48AM -0500, Luben Tuikov wrote:
> On 03/01/05 03:14, Douglas Gilbert wrote:
> >>  - scsi_error.c: scsi_normalize_sense
> >
> >
> >I introduced scsi_normalize_sense() recently, Christoph H.
> >proposed it should be static but Luben Tuikov (aic7xxx
> >maintainer) said he wished to use it in the future.
> >Hence it was left global.
> 
> Hi guys,
> 
> I think the idea of normalized sense is very good.
> Basically the question is if LLDD would submit normalized
> sense to SCSI Core or whether they would submit a pointer
> to raw sense data as returned by the device and let SCSI
> Core decipher it.
> 
> If the former, then it should be global, if the latter then
> it should be static to SCSI Core.

Doing it in the core means less duplication and avoiding updating
all drivers.

