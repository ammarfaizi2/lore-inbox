Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbTBXRdB>; Mon, 24 Feb 2003 12:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbTBXRdB>; Mon, 24 Feb 2003 12:33:01 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:3596 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261295AbTBXRdA>; Mon, 24 Feb 2003 12:33:00 -0500
Date: Mon, 24 Feb 2003 17:43:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dominik Brodowski <linux@brodo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] pcmcia: bus pcmcia_bus_type, driver_socket as interface
Message-ID: <20030224174312.A9951@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dominik Brodowski <linux@brodo.de>, linux-kernel@vger.kernel.org
References: <20030224162259.GA2277@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030224162259.GA2277@brodo.de>; from linux@brodo.de on Mon, Feb 24, 2003 at 05:22:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 05:22:59PM +0100, Dominik Brodowski wrote:
> Hi!
> 
> Patch #1: pcmcia-2.5.62-bus_drivers-3
> These patches add a new bus_type pcmcia_bus_type, and registers all pcmcia
> drivers with this bus. This is still done using the "old" registration
> calls; but over the long term this will move -- so that the pcmcia core
> knows about module->owner, for example.
> 
> Patch #2: pcmcia-2.5.62-ds-1
> This starts a change of "Driver Servies" to become a "interface" to
> pcmcia_socket-class devices. The interface_add_data call is commented out
> due to a driver model bug (deadlock) Patrick Mochel already knows about. Due
> to this, removing a driver services module or a socket won't currently work.

This looks really nice!  Could you post an example driver converted to use
pcmcia_register_driver() and friends?

