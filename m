Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWFGMoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWFGMoB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 08:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWFGMoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 08:44:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42461 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750714AbWFGMoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 08:44:00 -0400
Date: Wed, 7 Jun 2006 13:43:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       akpm@osdl.org, Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 4/4] Make Emulex lpfc driver legacy I/O port free
Message-ID: <20060607124353.GA31777@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Greg KH <greg@kroah.com>, akpm@osdl.org,
	Rajesh Shah <rajesh.shah@intel.com>,
	Grant Grundler <grundler@parisc-linux.org>,
	"bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@atrey.karlin.mff.cuni.cz
References: <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com> <447FA920.9060509@jp.fujitsu.com> <4484263C.1030508@jp.fujitsu.com> <20060606075812.GB19619@kroah.com> <448643B9.2080805@jp.fujitsu.com> <448644D6.9030907@jp.fujitsu.com> <20060607082448.GA31004@infradead.org> <4486C537.9040105@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4486C537.9040105@jp.fujitsu.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 09:23:19PM +0900, Kenji Kaneshige wrote:
> No. Your idea is very similar to the idea of previous version of my patche
> which had a bug. The problem is that it doesn't work if 
> pci_request_regions()
> is called before pci_enable_device*() (This is the correct order, though so
> many drivers breaks this rule).

Doesn't matter.  Drivers not using pci_enable_device_noioport should be
unaffect.  Any any driver you convert should be fixed to do thing in
the right order.

