Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbVDAFPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbVDAFPN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 00:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVDAFPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 00:15:13 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:63218 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262627AbVDAFOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 00:14:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=EJp8wPHLgAXxjGiKM1lIZ+vmW8odvHq0KCC2mUbsRqD+r9ZaKPGJv1LzO7E6GxMoAfZf9oH9q/NRJ0eZwEnzQTLGUBgNgEcbQJvpq+AXTEmRiRJoVFilvO/sqv61Qd2CTdqYGO7v36US4C6j7+HbysrImcB0gBkL2iPRjImaTMs=
Date: Fri, 1 Apr 2005 14:14:42 +0900
From: Tejun Heo <htejun@gmail.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 02/13] scsi: don't turn on REQ_SPECIAL on sgtable allocation failure.
Message-ID: <20050401051442.GC11318@htj.dyndns.org>
References: <20050331090647.FEDC3964@htj.dyndns.org> <20050331090647.C0E52845@htj.dyndns.org> <1112291625.5619.21.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112291625.5619.21.camel@mulgrave>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, James.

On Thu, Mar 31, 2005 at 11:53:45AM -0600, James Bottomley wrote:
> On Thu, 2005-03-31 at 18:08 +0900, Tejun Heo wrote:
> > 	Don't turn on REQ_SPECIAL on sgtable allocation failure.  This
> > 	was the last place where REQ_SPECIAL is turned on for normal
> > 	requests.
> 
> If you do this, you'll leak a command every time the sgtable allocation
> fails.

 AFAICT, not really.  We don't allocate another scsi_cmnd for normal
requests if req->special != NULL.

 Thanks.

-- 
tejun

