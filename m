Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263925AbSITXME>; Fri, 20 Sep 2002 19:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263946AbSITXME>; Fri, 20 Sep 2002 19:12:04 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:42723 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP
	id <S263925AbSITXMD>; Fri, 20 Sep 2002 19:12:03 -0400
Date: Fri, 20 Sep 2002 16:33:57 -0700
From: Matt Porter <porter@cox.net>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, mgreer@mvista.com, steiner@sgi.com,
       davidm@napali.hpl.hp.com
Subject: Re: can we drop early_serial_setup()?
Message-ID: <20020920163357.A30546@home.com>
References: <200209200459.g8K4xJcW011057@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200209200459.g8K4xJcW011057@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Thu, Sep 19, 2002 at 09:59:19PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 09:59:19PM -0700, David Mosberger wrote:
> int __init early_register_port (struct uart_port *port)
> {
> 	if (port->line >= ARRAY_SIZE(serial8250_ports))
> 		return -ENODEV;
> 
> 	serial8250_isa_init_ports();	/* force ISA defaults */
> 	serial8250_ports[port->line].port = *port;
> 	serial8250_ports[port->line].port.ops = &serial8250_pops;
> 	return 0;
> }

serial8250_ports and serial8250_pops are not static structs
in your tree?

-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
