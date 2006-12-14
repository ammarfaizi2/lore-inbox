Return-Path: <linux-kernel-owner+w=401wt.eu-S1751819AbWLNARo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbWLNARo (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 19:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWLNARo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 19:17:44 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60894 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822AbWLNARn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 19:17:43 -0500
Date: Wed, 13 Dec 2006 16:17:34 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] PCI-X/PCI-Express read control interfaces
Message-ID: <20061213161734.42821fdf@freekitty>
In-Reply-To: <1165808912.7260.14.camel@localhost.localdomain>
References: <20061208182241.786324000@osdl.org>
	<1165808912.7260.14.camel@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006 14:48:32 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2006-12-08 at 10:22 -0800, Stephen Hemminger wrote:
> > This patch set adds hooks to set PCI-X max read request size
> > and PCI-Express read request size. It is important that this be a PCI
> > subsystem function rather than a per device hack. That way, the PCI
> > system quirks can be used if needed.
> 
> Excellent, I've been needing that to work around bogus firmwares...
> 
> Ben.
> 
> 

I am thinking in the next revision of these of masking the distinction
between pci-x and pci express and just have:

pci_get_read_count
pci_get_max_read_count
pci_set_read_count



-- 
Stephen Hemminger <shemminger@osdl.org>
