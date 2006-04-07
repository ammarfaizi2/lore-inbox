Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWDGPJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWDGPJB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 11:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWDGPJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 11:09:01 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:49354 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964788AbWDGPJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 11:09:00 -0400
Subject: Re: [RFC] Patch to fix cdrom being confused on using kdump
From: Dave Hansen <haveblue@us.ibm.com>
To: rachita@in.ibm.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060407135714.GA25569@in.ibm.com>
References: <20060407135714.GA25569@in.ibm.com>
Content-Type: text/plain
Date: Fri, 07 Apr 2006 08:07:58 -0700
Message-Id: <1144422478.9731.210.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-07 at 19:27 +0530, Rachita Kothiyal wrote:
>  confused:
> +               if (( stat & DRQ_STAT) == DRQ_STAT) {
> +                       /* DRQ is set. Interrupt not welcome now. Ignore */
> +                       HWIF(drive)->OUTB((stat & 0xEF), IDE_STATUS_REG); 

Minor nit:  kill the space before stat:

	if ((stat & DRQ_STAT) == DRQ_STAT) {

-- Dave

