Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbUKSOnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbUKSOnY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 09:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbUKSOnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 09:43:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21947 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261433AbUKSOm2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 09:42:28 -0500
Message-ID: <419E0644.909@pobox.com>
Date: Fri, 19 Nov 2004 09:42:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>,
       Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: linux-2.4.28 released
References: <BF571719A4041A478005EF3F08EA6DF05EB481@pcsmail03.pcs.pc.ome.toshiba.co.jp> <20041118111235.GA26216@logos.cnet> <20041119134832.GA9552@havoc.gtf.org> <20041119135452.GA10422@devserv.devel.redhat.com>
In-Reply-To: <20041119135452.GA10422@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Fri, Nov 19, 2004 at 08:48:32AM -0500, Jeff Garzik wrote:
> 
>>PATA and SATA (DMA doesn't work for PATA, in split-driver configuration),
>>and there is no split-driver to worry about.
>>
>>I think there may need to be some code to prevent the IDE driver from
>>claiming the legacy ISA ports.
> 
> 
> Its called "request_resource". If you want the resource claim it. IDE will
> be a good citizen.

That's what the quirk does.  libata still needs to find out who obtained 
the resource, not blindly grab it (and fail).

	Jeff



