Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWJ1TC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWJ1TC5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 15:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWJ1TC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 15:02:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1187 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751354AbWJ1TC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 15:02:56 -0400
Date: Sat, 28 Oct 2006 20:02:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] acpi: fix single linked list manipulation
Message-ID: <20061028190254.GA7070@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>
References: <20061028185313.GK9973@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061028185313.GK9973@localhost>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2006 at 03:53:13AM +0900, Akinobu Mita wrote:
> This patch fixes single linked list manipulation for sub_driver.
> If the remving entry is not on the head of the sub_driver list,
> it goes into infinate loop.
> 
> Though that infinate loop doesn't happen. Because the only user of
> acpi_pci_register_dirver() is acpiphp.

Any chance to just switch the driver to use the list.h APIs instead
of opencoding lists?

