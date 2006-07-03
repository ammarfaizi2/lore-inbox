Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWGCRZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWGCRZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 13:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWGCRZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 13:25:26 -0400
Received: from gw.goop.org ([64.81.55.164]:13746 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751210AbWGCRZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 13:25:26 -0400
Message-ID: <44A95319.1010705@goop.org>
Date: Mon, 03 Jul 2006 10:25:45 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, greg@kroah.com, brice@myri.com
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org>	<44A8F8D2.1030101@reub.net> <20060703162958.d980ee6e.vsu@altlinux.ru>
In-Reply-To: <20060703162958.d980ee6e.vsu@altlinux.ru>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov wrote:
> These names are truncated - they should end with two hex digits:
>
> 	snprintf(device->bus_id, sizeof(device->bus_id), "%s:pcie%02x",
> 		 pci_name(parent), get_descriptor_id(port_type, service_type));
>
> Names were truncated at 18 characters, but sizeof(device->bus_id) is 20
> currently, so these names should just fit there.  I see that snprintf()
> was changed recently - maybe there is some off-by-one bug there?
>   

There was for a while, but it should be OK in -mm6.  Perhaps there's a 
stray patch hanging around in this kernel?

    J
